require 'spec_helper'

describe Synthetics::API::Locations do
  subject { described_class.new(client) }
  let(:client) { double(:client) }

  describe '#list' do
    let(:make_request) { subject.list }
    let(:expected_params) do
      {
        method: 'GET',
        path: '/locations'
      }
    end

    it_behaves_like 'a simple API request'
  end
end
