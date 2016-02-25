shared_examples_for 'a simple API request' do
  let(:response) { double(:response) }

  it 'makes a request with the correct parameters' do
    expect(client)
      .to receive(:request)
      .with(expected_params)
      .and_return(response)

    expect(make_request).to eq(response)
  end
end
