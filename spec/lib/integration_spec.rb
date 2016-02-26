require 'spec_helper'

# These specs use VCR to record HTTP requests and save them for later tests.
# To re-record the VCRs, you must have a valid key set at $SYNTHETICS_API_KEY.
# Credentials and UUIDs are filtered out from the VCR files.
#
# WARNING: Re-recording the VCRs will cause you to loose monitors or labels. It
# is highly recommended that you re-record these on a test account.
describe 'Integration', :vcr do
  subject { Synthetics.new(api_key) }
  let(:api_key) do
    ENV[Synthetics::API_KEY_ENVIRONMENT_VARIABLE] || 'TEST-API-KEY'
  end

  describe 'label lifecyle' do
    let(:label) { 'test:alpha' }
    let(:monitor_options) do
      {
        name: 'Test Monitor',
        frequency: 15,
        uri: 'https://google.com',
        locations: %w(AWS_US_WEST_1),
        type: 'simple'
      }
    end

    it 'can add and remove labels from monitors' do
      subject.monitors.create(monitor_options)
      monitor = subject.monitors.list[:monitors].find do |hash|
        hash[:name] == monitor_options[:name]
      end
      subject.label(label).attach(monitor[:id])
      expect(subject.label(label).monitors[:monitors]).to include(monitor)
      expect(subject.labels.list[:labels])
        .to include(type: 'test', value: 'alpha')
      subject.label(label).remove(monitor[:id])
      expect(subject.label(label).monitors[:monitors])
        .to_not include(monitor)
      subject.monitor(monitor[:id]).destroy
    end
  end

  describe 'locations' do
    let(:locations) { subject.locations.list }

    it 'can list them' do
      expect(locations).to_not be_empty
      expect(locations).to be_all do |location|
        location.key?(:private) &&
          location.key?(:name) &&
          location.key?(:label)
      end
    end
  end

  describe 'monitors' do
    let(:create_options) do
      {
        name: 'Google Monitor',
        frequency: 15,
        uri: 'https://google.com',
        locations: %w(AWS_US_WEST_1),
        type: 'script_browser'
      }
    end
    let(:update_options) { create_options.merge(frequency: 30) }

    it 'can perform CRUD operations' do
      subject.monitors.create(create_options)
      monitor = subject.monitors.list[:monitors].find do |hash|
        hash[:name] == create_options[:name]
      end
      subject.monitor(monitor[:id]).update(update_options)
      monitor = subject.monitor(monitor[:id]).show
      expect(monitor[:frequency]).to eq(30)
      subject.monitor(monitor[:id]).update_script('test script')
      subject.monitor(monitor[:id]).destroy
      expect(subject.monitors.list[:monitors]).to be_none do |hash|
        hash[:id] == monitor[:id]
      end
    end
  end
end
