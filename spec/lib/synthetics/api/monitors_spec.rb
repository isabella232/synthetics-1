require 'spec_helper'

describe Synthetics::API::Monitors do
  subject { described_class.new(client) }
  let(:client) { double(:client) }

  describe '#list' do
    let(:make_request) { subject.list }
    let(:expected_params) do
      {
        method: 'GET',
        path: '/monitors'
      }
    end

    it_behaves_like 'a simple API request'
  end

  describe '#create' do
    let(:make_request) { subject.create(options) }
    let(:expected_params) do
      {
        method: 'POST',
        path: '/monitors',
        body: options
      }
    end
    let(:options) { double(:options) }

    it_behaves_like 'a simple API request'
  end
end
