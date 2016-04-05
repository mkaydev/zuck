module Zuck
 module FbObject
   module Write
    def self.included(base)
      base.extend(ClassMethods)
    end

    def update(key, new_value)
      self.class.raise_if_read_only

      data = { key.to_sym => new_value }
      result = post(graph, path, data)

      if result['success']
        self.public_send("#{key}=", new_value)
      end
    end

    # TODO: The allowed keys are different depending on the action
    # (read, update, create)
    #
    # if save should be used, someone needs to keep track of changes
    # and only add the changed parameters to the POST request
    #
    # additionally it would make sense to have a sanity check against the
    # allowed parameters for update in the fb api
    def save
      self.class.raise_if_read_only

      # Tell facebook to return
      data = @hash_delegator_hash.merge(redownload: 1)
      data = data.stringify_keys

      # Don't post ids, because facebook doesn't like it
      data = data.keep_if{ |k,v| k != "id" }

      # Update on facebook
      result = post(graph, path, data)

      # The data is nested by name and id, e.g.
      #
      #     "campaigns" => { "12345" => "data" }
      #
      # Since we only put one at a time, we'll fetch this like that.
      data = result["data"].values.first.values.first
      known_data = data.keep_if{|k,v| known_keys.include?(k.to_sym) }

      merge_data(known_data)
      result["result"]
    end

    def destroy
      self.class.destroy(graph, path)
    end

    module ClassMethods

      def raise_if_read_only
        return unless read_only?
        raise Zuck::Error::ReadOnly.new("#{self} is read_only")
      end

      def create(graph, data, parent=nil, path=nil)
        raise_if_read_only
        p = path || parent.path

        # We want facebook to return the data of the created object
        data["redownload"] = 1

        # Create
        result = create_connection(graph, p, list_path, data)

        # If the redownload flag was supported, the data is nested by
        # name and id, e.g.
        #
        #     "campaigns" => { "12345" => "data" }
        #
        # Since we only create one at a time, we can just say:
        if d=result['data']
          data = d.values.first.values.first

        # Redownload was not supported, in this case facebook returns
        # just {"id": "12345"}
        elsif result['id']
          data = result

        # Don't know what to do. No id and no data. I need an adult.
        else
          raise "Invalid response received, found neither a data nor id key in #{result}"
        end

        # Return a new instance
        new(graph, data, parent)
      end

      def destroy(graph, id)
        raise_if_read_only
        delete(graph, id)
      end

    end

   end
 end
end
