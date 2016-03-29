module Zuck
  class AdCampaign < RawFbObject

    known_keys :id,
               :account_id,
               :objective,
               :name,
               :status,
               :buying_type

    parent_object :ad_account, as: :account_id
    list_path     :campaigns
    connections   :ad_campaigns
  end
end
