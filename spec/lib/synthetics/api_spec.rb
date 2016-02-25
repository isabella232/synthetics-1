require 'spec_helper'

describe Synthetics::API do
  subject { described_class.new(client) }
  let(:client) { double(:client) }

  describe '#label' do
    let(:label) { 'test-label' }
    let(:api) { subject.label(label) }

    it 'returns a Label API' do
      expect(api).to be_a(Synthetics::API::Label)
      expect(api.client).to eq(client)
      expect(api.label).to eq(label)
    end
  end

  describe '#labels' do
    let(:api) { subject.labels }

    it 'returns a Label API' do
      expect(api).to be_a(Synthetics::API::Labels)
      expect(api.client).to eq(client)
    end
  end

  describe '#locations' do
    let(:api) { subject.locations }

    it 'returns a Label API' do
      expect(api).to be_a(Synthetics::API::Locations)
      expect(api.client).to eq(client)
    end
  end

  describe '#monitor' do
    let(:monitor_uuid) { 'TEST-MONITOR-UUID' }
    let(:api) { subject.monitor(monitor_uuid) }

    it 'returns a Label API' do
      expect(api).to be_a(Synthetics::API::Monitor)
      expect(api.client).to eq(client)
      expect(api.monitor_uuid).to eq(monitor_uuid)
    end
  end

  describe '#monitors' do
    let(:api) { subject.monitors }

    it 'returns a Label API' do
      expect(api).to be_a(Synthetics::API::Monitors)
      expect(api.client).to eq(client)
    end
  end
end
