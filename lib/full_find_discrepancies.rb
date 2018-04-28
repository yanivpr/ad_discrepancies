require_relative 'campaigns'
require_relative 'remote_ads'
require_relative 'find_discrepancies'

module FullFindDiscrepancies
  module_function

  def call
    campaigns = Campaigns.fetch
    remote_ads = RemoteAds.fetch

    FindDiscrepancies.new(campaigns: campaigns, remote_ads: remote_ads).call
  end
end
