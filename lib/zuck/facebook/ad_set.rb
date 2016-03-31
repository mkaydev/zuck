require 'zuck/facebook/ad_creative'

module Zuck
  class AdSet < RawFbObject

    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/reference/ads-api/adset/v2.5)
    known_keys :account_id,
               :adlabels,
               :adset_schedule,
               :bid_amount,
               :bid_info,
               :billing_event,
               :budget_remaining,
               :campaign,
               :campaign_id,
               :configured_status,
               :created_time,
               :creative_sequence,
               :daily_budget,
               :effective_status,
               :end_time,
               :frequency_cap_reset_period,
               :frequency_control_specs,
               :id,
               :frequency_cap,
               :is_autobid,
               :lifetime_budget,
               :lifetime_frequency_cap,
               :lifetime_imps,
               :name,
               :optimization_goal,
               :pacing_type,
               :product_ad_behavior,
               :promoted_object,
               :recommendations,
               :rf_prediction_id,
               :rtb_flag,
               :start_time,
               :status,
               :targeting,
               :updated_time

    parent_object :ad_account, as: :account_id
    list_path     :adsets # Yes, this is correct, "for legacy reasons"
    connections   :ad_groups, :ad_creatives

  end
end
