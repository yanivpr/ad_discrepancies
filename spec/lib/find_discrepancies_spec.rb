require 'find_discrepancies'
require 'spec_helper'

RSpec.describe FindDiscrepancies do
  let(:test_campaign) { Struct.new(:status, :external_reference, :ad_description) }
  let(:test_remote_ad) { Struct.new(:status, :reference, :description) }

  describe '#call' do
    context 'when remote ads are empty and empty campaigns are empty' do
      it 'returns empty discrepancies' do
        find_discrepancies = described_class.new(campaigns: [], remote_ads: [])

        expect(find_discrepancies.call).to eq([].to_json)
      end
    end

    context 'when remote ads and campaigns do not have discrepancies' do
      it 'returns empty discrepancies' do
        campaigns = [test_campaign.new('active', '123', 'description')]
        remote_ads = [test_remote_ad.new('active', '123', 'description')]

        find_discrepancies = described_class.new(campaigns: campaigns, remote_ads: remote_ads)

        expect(find_discrepancies.call).to eq([].to_json)
      end
    end

    context 'when remote ads and campaigns differ in status' do
      it 'returns discrepancies' do
        campaigns = [
          test_campaign.new('active', '123', 'description'),
          test_campaign.new('active', '123', 'description')
        ]
        remote_ads = [
          test_remote_ad.new('active', '123', 'description'),
          test_remote_ad.new('disabled', '123', 'description')
        ]

        find_discrepancies = described_class.new(campaigns: campaigns, remote_ads: remote_ads)

        expect(find_discrepancies.call).to eq(
          [
            {
              remote_reference: '123',
              discrepancies: [
                status: {
                  remote: 'disabled',
                  local: 'active'
                }
              ]
            }
          ].to_json
        )
      end
    end
  end
end
