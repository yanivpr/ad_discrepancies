require 'full_find_discrepancies'
require 'spec_helper'

RSpec.describe FullFindDiscrepancies do
  describe '.call' do
    before do
      allow(Campaigns).to receive(:fetch).and_return(['some campaigns'])
      allow(RemoteAds).to receive(:fetch).and_return(['some remote ads'])
      allow(FindDiscrepancies).to receive(:new).and_return(find_discrepancies)
      allow(find_discrepancies).to receive(:call).and_return('some result')
    end

    let(:find_discrepancies) { instance_double('FindDiscrepancies') }

    it { expect(described_class.call).to eq('some result') }
  end
end
