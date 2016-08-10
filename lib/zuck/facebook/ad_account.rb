module Zuck
  class AdAccount < RawFbObject
    include Zuck::Helpers

    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/marketing-api/reference/ad-account/v2.5)
    known_keys :id,
               :account_groups,
               :account_id,
               :account_status,
               :age,
               :agency_client_declaration,
               :amount_spent,
               :balance,
               :business,
               :business_city,
               :business_country_code,
               :business_name,
               :business_state,
               :business_street,
               :business_street2,
               :business_zip,
               :can_create_brand_lift_study,
               :capabilities,
               :created_time,
               :currency,
               :disable_reason,
               :end_advertiser,
               :end_advertiser_name,
               :failed_delivery_checks,
               :funding_source,
               :funding_source_details,
               :has_migrated_permissions,
               :io_number,
               :is_notifications_enabled,
               :is_personal,
               :is_prepay_account,
               :is_tax_id_required,
               :line_numbers,
               :media_agency,
               :min_campaign_group_spend_cap,
               :min_daily_budget,
               :name,
               :offsite_pixels_tos_accepted,
               :owner,
               :partner,
               :rf_spec,
               :spend_cap,
               :tax_id,
               :tax_id_status,
               :tax_id_type,
               :timezone_id,
               :timezone_name,
               :timezone_offset_hours_utc,
               :tos_accepted,
               :user_role

    list_path 'me/adaccounts'
    connections :ad_campaigns, :ad_sets, :ad_groups

    def self.all(graph = Zuck.graph)
      super(graph)
    end

    def path
      normalize_account_id(id)
    end

    def set_data(data)
      super
      self.id = normalize_account_id(id)
    end
  end
end
