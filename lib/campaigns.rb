require 'campaign'

module Campaigns
  class << self
    def fetch
      campaigns = database[:campaigns]
      campaigns.map { |campaign| Campaign.new(*campaign.values) }
    end

    private

    def database
      {
        campaigns: [
          { id: 1001, job_id: 42, external_reference: '1', status: 'enabled',
            ad_description: 'Description for campaign 11'},
          { id: 1002, job_id: 43, external_reference: '2', status: 'disabled',
            ad_description: 'Description for campaign 12'},
          { id: 1003, job_id: 44, external_reference: '3', status: 'enabled',
            ad_description: 'Description for campaign 13'}
        ]
      }
    end
  end
end
