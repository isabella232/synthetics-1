require 'spec_helper'

describe Synthetics do
  it 'has a version number' do
    expect(Synthetics::VERSION).not_to be nil
  end

  describe '.new' do
    let(:api_key) { 'TEST-API-KEY' }

    context 'when an API key is given' do
      it 'creates a new API with that key' do
        expect(subject.new(api_key)).to be_a(Synthetics::API)
      end
    end

    context 'when no API key is given' do
      context 'when the environment variable is not set' do
        it 'raises a NoAPIKeyError' do
          expect { subject.new }
            .to raise_error(Synthetics::NoAPIKeyError)
        end
      end

      context 'when the environment variable is set' do
        before { ENV[Synthetics::API_KEY_ENVIRONMENT_VARIABLE] = api_key }
        after { ENV[Synthetics::API_KEY_ENVIRONMENT_VARIABLE] = nil }

        it 'creates a new API with that environment variable' do
          expect(subject.new).to be_a(Synthetics::API)
        end
      end
    end
  end
end
