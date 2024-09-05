# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyHubspot::LineItem do
  before :all do
    EasyHubspot.config do |config|
      config.access_token = 'YOUR-PRIVATE-ACCESS-TOKEN'
    end
  end

  describe 'get_line_item' do
    context 'when line_item is found using line_item_id' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/line_items/4118976207')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_line_item_json('get_line_item'), headers: {})
      end

      let(:response) { described_class.get_line_item('4118976207') }

      it 'returns a line item' do
        expect(response[:id]).to eq '4118976207'
        expect(response[:properties][:amount]).to eq '215.460'
        expect(response[:properties][:quantity]).to eq '3'
        expect(response[:properties][:hs_product_id]).to eq '1175864298'
      end
    end

    context 'when line_item is found using line_item_id while overwriting the access_token' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/line_items/4118976207')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer SOME-OTHER-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_line_item_json('get_line_item'), headers: {})
        allow(EasyHubspot::Client).to receive(:do_get).and_call_original
      end

      let(:response) { described_class.get_line_item('4118976207', 'SOME-OTHER-TOKEN') }

      it 'returns a line item' do
        expect(response[:id]).to eq '4118976207'
        expect(response[:properties][:amount]).to eq '215.460'
        expect(response[:properties][:quantity]).to eq '3'
        expect(response[:properties][:hs_product_id]).to eq '1175864298'
      end

      it 'called the client method with the right token' do
        described_class.get_line_item('4118976207', 'SOME-OTHER-TOKEN')
        expect(EasyHubspot::Client).to have_received(:do_get).with('crm/v3/objects/line_items/4118976207',
                                                                   { 'Content-Type' => 'application/json',
                                                                     'Authorization' => 'Bearer SOME-OTHER-TOKEN' })
      end
    end
  end

  describe 'get_line_items' do
    context 'when line items are found' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/line_items')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_line_item_json('get_line_items'), headers: {})
      end

      let(:response) { described_class.get_line_items }

      it 'returns a list of line items' do
        results = response[:results]
        expect(results.count).to eq 2
      end
    end

    context 'when line_item is found while overwriting the access_token' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/line_items')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer SOME-OTHER-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_line_item_json('get_line_item'), headers: {})
        allow(EasyHubspot::Client).to receive(:do_get).and_call_original
      end

      let(:response) { described_class.get_line_items('SOME-OTHER-TOKEN') }

      it 'returns a line item' do
        expect(response[:id]).to eq '4118976207'
        expect(response[:properties][:amount]).to eq '215.460'
        expect(response[:properties][:quantity]).to eq '3'
        expect(response[:properties][:hs_product_id]).to eq '1175864298'
      end

      it 'called the client method with the right token' do
        described_class.get_line_items('SOME-OTHER-TOKEN')
        expect(EasyHubspot::Client).to have_received(:do_get).with('crm/v3/objects/line_items',
                                                                   { 'Content-Type' => 'application/json',
                                                                     'Authorization' => 'Bearer SOME-OTHER-TOKEN' })
      end
    end
  end

  describe 'create_line_item' do
    before do
      stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/line_items')
        .with(
          body: 'properties%5Bname%5D=Blue%20Jeans&properties%5Bhs_product_id%5D=1175864298&properties%5Bprice%5D=71.82&properties%5Bquantity%5D=3',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        ).to_return(status: 200, body: load_line_item_json('create_line_item'), headers: {})
      stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/line_items')
        .with(
          body: 'properties%5Bname%5D=Blue%20Jeans&properties%5Bhs_product_id%5D=1175864298&properties%5Bprice%5D=71.82&properties%5Bquantity%5D=3',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer ANOTHER-ACCESS-TOKEN',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        ).to_return(status: 200, body: load_line_item_json('create_line_item'), headers: {})
      allow(EasyHubspot::Base).to receive(:headers).and_call_original
    end

    let(:body) do
      { properties: { name: 'Blue Jeans', hs_product_id: '1175864298', price: '71.82', quantity: '3' } }
    end

    let(:response) { described_class.create_line_item(body) }

    it 'returns a line item' do
      expect(response[:id]).to eq '4118976207'
      expect(response[:properties][:price]).to eq '71.82'
      expect(response[:properties][:quantity]).to eq '3'
      expect(response[:properties][:amount]).to eq '215.460'
      expect(response[:properties][:name]).to eq 'Blue Jeans'
    end

    it 'calls uses the correct access_token when overwritten' do
      described_class.create_line_item(body, 'ANOTHER-ACCESS-TOKEN')
      expect(EasyHubspot::Base).to have_received(:headers).with('ANOTHER-ACCESS-TOKEN')
    end
  end

  describe 'update_line_item' do
    context 'when line item is found using line_item_id' do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/line_items/4120050126')
          .with(
            body: 'properties%5Bquantity%5D=2',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_line_item_json('update_line_item'), headers: {})

        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/line_items/4120050126')
          .with(
            body: 'properties%5Bquantity%5D=2',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer ANOTHER-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_line_item_json('update_line_item'), headers: {})
        allow(EasyHubspot::Base).to receive(:headers).and_call_original
      end

      let(:body) do
        { properties: { quantity: '2' } }
      end

      let(:response) { described_class.update_line_item(4_120_050_126, body) }

      it 'returns a line item' do
        expect(response[:id]).to eq '4120050126'
        expect(response[:properties][:quantity]).to eq '2'
        expect(response[:properties][:price]).to eq '71.82'
        expect(response[:properties][:amount]).to eq '143.640'
      end

      it 'calls headers with the right arguments' do
        described_class.update_line_item(4_120_050_126, body, 'ANOTHER-ACCESS-TOKEN')
        expect(EasyHubspot::Base).to have_received(:headers).with('ANOTHER-ACCESS-TOKEN')
      end
    end
  end

  describe 'delete_line_item' do
    let(:success) { { status: 'success' } }

    context 'when line item is found using line_item_id' do
      before do
        stub_request(:delete, 'https://api.hubapi.com/crm/v3/objects/line_items/4120050126')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 204, body: '', headers: {})

        stub_request(:delete, 'https://api.hubapi.com/crm/v3/objects/line_items/4120050126')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer ANOTHER-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 204, body: '', headers: {})
        allow(EasyHubspot::Base).to receive(:headers).and_call_original
      end

      let(:response) { described_class.delete_line_item('4120050126') }

      it 'returns no content' do
        expect(response).to eq success
      end

      it 'calls headers with the right arguments' do
        described_class.delete_line_item('4120050126', 'ANOTHER-ACCESS-TOKEN')
        expect(EasyHubspot::Base).to have_received(:headers).with('ANOTHER-ACCESS-TOKEN')
      end
    end
  end

  describe 'errors' do
    context "when trying to update a line item that doesn't exist" do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/line_items/123')
          .with(
            body: 'properties%5Bquantity%5D=3',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          ).to_return(status: 200, body: load_line_item_json('not_found'), headers: {})
      end

      let(:body) do
        { properties: { quantity: '3' } }
      end

      it 'raises a HubspotApiError' do
        expect do
          described_class.update_line_item(123, body)
        end.to raise_error(EasyHubspot::HubspotApiError)
      end
    end

    context 'when hubspot api returns a 404 reponse code' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/line_items/404')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 404, body: nil, headers: {})
      end

      let(:response) { described_class.get_line_item('404') }

      it 'returns a 404 status error message' do
        expect(response).to eq({ status: 'error', message: '404 Not Found' })
      end
    end
  end
end
