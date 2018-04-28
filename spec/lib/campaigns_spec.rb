require 'campaigns'
require 'spec_helper'

RSpec.describe Campaigns do
  describe '.fetch' do
    it 'fetches all campaigns' do
      campaigns = described_class.fetch

      expect(campaigns).to eq(
        [
          Campaign.new(1001, 42, '1', 'enabled', 'Description for campaign 11'),
          Campaign.new(1002, 43, '2', 'disabled', 'Description for campaign 12'),
          Campaign.new(1003, 44, '3', 'disabled', 'Description for campaign 13.1')
        ]
      )
    end
  end
end
