module Zuck
  class AdCreative < RawFbObject
    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/marketing-api/reference/ad-creative/v2.7)
    known_keys :id,
               :adlabels,
               :applink_treatment,
               :body,
               :call_to_action_type,
               :image_crops,
               :image_hash,
               :image_url,
               :instagram_actor_id,
               :instagram_permalink_url,
               :link_og_id,
               :link_url,
               :name,
               :object_id,
               :object_story_id,
               :object_story_spec,
               :object_type,
               :object_url,
               :platform_customizations,
               :product_set_id,
               :run_status,
               :template_url,
               :thumbnail_url,
               :title,
               :url_tags

    parent_object :ad_group
    list_path :adcreatives
  end
end
