require 'zuck/facebook/ad_creative'

module Zuck
  class AdGroup < RawFbObject

    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/reference/ads-api/adgroup/v2.7)
    known_keys :id,
               :account_id,
               :ad_review_feedback,
               :adlabels,
               :adset,
               :adset_id,
               :bid_amount,
               :bid_info,
               :bid_type,
               :campaign,
               :campaign_id,
               :configured_status,
               :conversion_specs,
               :created_time,
               :creative,
               :effective_status,
               :last_updated_by_app_id,
               :name,
               :recommendations,
               :status,
               :tracking_specs,
               :updated_time

    parent_object :ad_campaign
    list_path :ads
    connections :ad_creatives

    def self.create(graph, data, ad_set)
      path = ad_set.ad_account.path
      data['adset_id'] = ad_set.id
      super(graph, data, ad_set, path)
    end
  end
end
