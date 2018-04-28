require_relative 'comparison'
require 'json'

class FindDiscrepancies
  def initialize(campaigns:, remote_ads:)
    @campaigns = store_efficiently(campaigns)
    @remote_ads = remote_ads
    @discrepancies = []
  end

  def call
    discrepancies = @remote_ads.each_with_object([]) do |remote_ad, acc|
      campaign = @campaigns[remote_ad.reference]
      comparison = Comparison.new(campaign: campaign, remote_ad: remote_ad)
      comparison.compare
      acc << discrepancies_data(remote_ad.reference, comparison.discrepancies) if comparison.has_discrepancies?
    end

    discrepancies.to_json
  end

  private

  def store_efficiently(campaigns)
    campaigns.each_with_object({}) { |campaign, acc| acc[campaign.external_reference] = campaign }
  end

  def discrepancies_data(remote_reference, discrepancies)
    {
      remote_reference: remote_reference,
      discrepancies: discrepancies
    }
  end
end
