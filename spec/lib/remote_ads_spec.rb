require 'remote_ads'
require 'spec_helper'

RSpec.describe RemoteAds do
  describe '.fetch' do
    it 'fetches all ads' do
      body = %Q({ "ads": [ { "reference": "1", "status": "enabled", "description": "Description for campaign 11" }, { "reference": "2", "status": "disabled", "description": "Description for campaign 12" }, { "reference": "3", "status": "enabled", "description": "Description for campaign 13" } ] })
      stub_request(:get, 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df')
        .to_return(body: body, status: 200, headers: {})

      ads = described_class.fetch

      expect(ads).to eq(
        [
          RemoteAd.new('1', 'enabled', 'Description for campaign 11'),
          RemoteAd.new('2', 'disabled', 'Description for campaign 12'),
          RemoteAd.new('3', 'enabled', 'Description for campaign 13')
        ]
      )
    end
  end
end
