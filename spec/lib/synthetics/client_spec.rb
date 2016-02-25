require 'spec_helper'

describe Synthetics::Client do
  subject { described_class.new(api_key) }
  let(:api_key) { 'PHONY_API_KEY' }

  describe '#request' do
    let(:excon) { double(:excon) }
    let(:options) do
      {
        method: 'GET',
        path: '/test',
        body: {
          test_key: 1
        }
      }
    end
    let(:formatted_options) do
      {
        method: 'GET',
        path: '/synthetics/api/v1/test',
        headers: {
          'Content-Type' => 'application/json',
          'X-API-Key' => api_key
        },
        expects: 200..204,
        body: '{"testKey":1}'
      }
    end

    before do
      allow(Excon)
        .to receive(:new)
        .with(Synthetics::API_HOST)
        .and_return(excon)
    end

    context 'when there is a server error' do
      before do
        allow(excon)
          .to receive(:request)
          .with(formatted_options)
          .and_raise(Excon::Errors::ServerError.new(nil))
      end

      it 'raises a ServerError' do
        expect { subject.request(options) }
          .to raise_error(Synthetics::ServerError)
      end
    end

    context 'when there is a client error' do
      before do
        allow(excon)
          .to receive(:request)
          .with(formatted_options)
          .and_raise(Excon::Errors::ClientError.new(nil))
      end

      it 'raises a ClientError' do
        expect { subject.request(options) }
          .to raise_error(Synthetics::ClientError)
      end
    end

    context 'when the request is successful' do
      let(:body) { '' }
      let(:response) { double(:resonse, body: body) }

      before do
        allow(excon)
          .to receive(:request)
          .with(formatted_options)
          .and_return(response)
      end

      context 'when there is an empty response' do
        it 'formats the request options returns nil' do
          expect(subject.request(options)).to be_nil
        end
      end

      context 'when there is an nonempty response' do
        context 'and the JSON is malformed' do
          let(:body) { 'not even close to JSON' }

          it 'raises a ParseError' do
            expect { subject.request(options) }
              .to raise_error(Synthetics::ParseError)
          end
        end

        context 'and the JSON is well formed' do
          let(:body) { '{"alphaBeta":true}' }
          let(:expected) { { alpha_beta: true } }

          it 'parses the JSON' do
            expect(subject.request(options)).to eq(expected)
          end
        end
      end
    end
  end
end
