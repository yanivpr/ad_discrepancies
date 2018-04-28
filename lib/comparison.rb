class Comparison
  attr_reader :discrepancies

  def initialize(campaign:, remote_ad:)
    @campaign = campaign
    @remote_ad = remote_ad
    @discrepancies = []
  end

  def compare
    compare_fields(:status, :status)
    compare_fields(:ad_description, :description)
  end

  def has_discrepancies?
    !@discrepancies.empty?
  end

  private

  def compare_fields(campaign_field, remote_field)
    in_campaign = @campaign.send(campaign_field)
    in_remote = @remote_ad.send(remote_field)

    if in_campaign != in_remote
      @discrepancies << {
        remote_field => {
          remote: in_remote,
          local: in_campaign
        }
      }
    end
  end
end
