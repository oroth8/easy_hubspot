# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyHubspot::Base do
  global_access_token = 'YOUR-GLOBAL-ACCESS-TOKEN'

  before :all do
    EasyHubspot.config do |config|
      config.access_token = global_access_token
    end
  end

  describe '#headers' do
    context 'when using the global access_token' do
      let(:expected_headers) do
        { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{global_access_token}" }
      end

      it 'returns the expected Authorization Header' do
        expect(described_class.headers).to eq(expected_headers)
      end
    end

    context 'when overriding the global access_token' do
      let(:custom_access_token) { 'CUSTOM-PER-CALL-ACCESS-TOKEN' }
      let(:expected_headers) do
        { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{custom_access_token}" }
      end

      it 'returns the expected Authorization Header' do
        expect(described_class.headers(custom_access_token)).to eq(expected_headers)
      end
    end
  end
end
