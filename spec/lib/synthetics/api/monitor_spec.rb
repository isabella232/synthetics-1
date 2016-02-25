require 'spec_helper'

describe Synthetics::API::Monitor do
  subject { described_class.new(client, monitor_uuid) }
  let(:client) { double(:client) }
  let(:monitor_uuid) { 'TEST-MONITOR-UUID' }

  describe '#fetch' do
    let(:make_request) { subject.fetch }
    let(:expected_params) do
      {
        method: 'GET',
        path: '/monitors/TEST-MONITOR-UUID'
      }
    end

    it_behaves_like 'a simple API request'
  end

  describe '#update' do
    let(:make_request) { subject.update(options) }
    let(:monitor_uuid) { 'TEST-MONITOR-UUID' }
    let(:expected_params) do
      {
        method: 'PUT',
        path: '/monitors/TEST-MONITOR-UUID',
        body: options
      }
    end
    let(:options) { double(:options) }

    it_behaves_like 'a simple API request'
  end

  describe '#update_script' do
    let(:make_request) { subject.update_script(script) }
    let(:monitor_uuid) { 'TEST-MONITOR-UUID' }
    let(:expected_params) do
      {
        method: 'PUT',
        path: '/monitors/TEST-MONITOR-UUID/script',
        body: { script_text: base64_script }
      }
    end
    let(:script) { 'var someJS = function() {};' }
    let(:base64_script) { Base64.strict_encode64(script) }

    it_behaves_like 'a simple API request'
  end

  describe '#destroy' do
    let(:make_request) { subject.destroy }
    let(:expected_params) do
      {
        method: 'DELETE',
        path: '/monitors/TEST-MONITOR-UUID'
      }
    end

    it_behaves_like 'a simple API request'
  end
end
