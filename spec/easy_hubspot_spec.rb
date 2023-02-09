# frozen_string_literal: true

require 'spec_helper'

describe EasyHubspot do
  describe '.config' do
    before do
      described_class.config do |config|
        config.access_token = 'YOUR-OWN-API-KEY'
        config.base_url = 'http://any.other.host'
      end
    end

    it { expect(described_class.configuration.access_token).to eq 'YOUR-OWN-API-KEY' }
    it { expect(described_class.configuration.base_url).to eq 'http://any.other.host' }
  end
end
