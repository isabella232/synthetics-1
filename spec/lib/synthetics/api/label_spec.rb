require 'spec_helper'

describe Synthetics::API::Label do
  subject { described_class.new(client, label) }
  let(:client) { double(:client) }
  let(:label) { 'test-label' }

  describe '#monitors' do
    let(:make_request) { subject.monitors }
    let(:expected_params) do
      {
        method: 'GET',
        path: '/monitors/labels/test-label'
      }
    end

    it_behaves_like 'a simple API request'
  end

  describe '#attach' do
    let(:make_request) { subject.attach(monitor_uuid) }
    let(:monitor_uuid) { 'TEST-MONITOR-UUID' }
    let(:expected_params) do
      {
        method: 'POST',
        path: '/monitors/TEST-MONITOR-UUID/labels',
        body: { category: 'test-label' }
      }
    end

    it_behaves_like 'a simple API request'
  end

  describe '#remove' do
    let(:make_request) { subject.remove(monitor_uuid) }
    let(:monitor_uuid) { 'TEST-MONITOR-UUID' }
    let(:expected_params) do
      {
        method: 'DELETE',
        path: '/monitors/TEST-MONITOR-UUID/labels/test-label'
      }
    end

    it_behaves_like 'a simple API request'
  end
end
