require 'remote_ad'
require 'net/http'
require 'oj'

module RemoteAds
  module_function

  REMOTE_ADS_URL = URI('https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df')

  def fetch
    response = Net::HTTP.get(REMOTE_ADS_URL)
    ads = Oj.load(response)['ads']
    ads.map { |ad| RemoteAd.new(*ad.values) }
  end
end
