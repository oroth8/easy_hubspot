
require 'spec_helper'

describe EasyHubspot do
  context ".config" do
    before do
      EasyHubspot.config do |config|
        config.access_token  = 'YOUR-OWN-API-KEY'
        config.base_url = 'http://any.other.host'
      end
    end

    it { expect(EasyHubspot.configuration.access_token).to eq 'YOUR-OWN-API-KEY' }
    it { expect(EasyHubspot.configuration.base_url).to eq 'http://any.other.host' }
  end
end