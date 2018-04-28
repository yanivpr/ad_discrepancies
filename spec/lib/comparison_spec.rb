require 'comparison'
require 'spec_helper'

RSpec.describe Comparison do
  let(:test_campaign) { Struct.new(:status, :external_reference, :ad_description) }
  let(:test_remote_ad) { Struct.new(:status, :reference, :description) }

  describe '#compare' do
    it 'has no discrepancies when campaign and remote ad have the same details' do
      campaign = test_campaign.new('active', '123', 'description')
      remote_ad = test_remote_ad.new('active', '123', 'description')

      comparison = described_class.new(campaign: campaign, remote_ad: remote_ad)
      comparison.compare

      expect(comparison.has_discrepancies?).to eq(false)
    end

    it 'has discrepancies when status differs' do
      campaign = test_campaign.new('active', '123', 'description')
      remote_ad = test_remote_ad.new('disabled', '123', 'description')

      comparison = described_class.new(campaign: campaign, remote_ad: remote_ad)
      comparison.compare

      expect(comparison.has_discrepancies?).to eq(true)
      expect(comparison.discrepancies).to eq(
        [
          status: {
            remote: 'disabled',
            local: 'active'
          }
        ]
      )
    end

    it 'has discrepancies when description differs' do
      campaign = test_campaign.new('active', '123', 'local description')
      remote_ad = test_remote_ad.new('active', '123', 'remote description')

      comparison = described_class.new(campaign: campaign, remote_ad: remote_ad)
      comparison.compare

      expect(comparison.has_discrepancies?).to eq(true)
      expect(comparison.discrepancies).to eq(
        [
          description: {
            remote: 'remote description',
            local: 'local description'
          }
        ]
      )
    end

    it 'has discrepancies when status and description differ' do
      campaign = test_campaign.new('active', '123', 'local description')
      remote_ad = test_remote_ad.new('disabled', '123', 'remote description')

      comparison = described_class.new(campaign: campaign, remote_ad: remote_ad)
      comparison.compare

      expect(comparison.has_discrepancies?).to eq(true)
      expect(comparison.discrepancies).to eq(
        [
          {
            status: {
              remote: 'disabled',
              local: 'active'
            }
          },
          {
            description: {
              remote: 'remote description',
              local: 'local description'
            }
          }
        ]
      )
    end
  end
end
