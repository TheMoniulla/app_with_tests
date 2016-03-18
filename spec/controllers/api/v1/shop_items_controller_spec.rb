require 'rails_helper'

describe Api::V1::ShopItemsController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let!(:shop_item) { create(:shop_item, name: "name") }
    let(:call_request) { get :index }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)['shop_items'].count).to eq 1
      expect(JSON.parse(response.body)['shop_items'].first).to include('name' => 'name')
    end
  end

  describe '#show' do
    let!(:shop_item) { create(:shop_item, name: 'name') }
    let(:call_request) { get :show, id: shop_item }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)['shop_item']).to include("name" => "name")
    end
  end

  describe '#create' do
    let(:call_request) { post :create, shop_item: attributes }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:shop_item, name: 'food') }

      it { expect { call_request }.to change { ShopItem.count }.by 1 }

      it 'returns correct json' do
        call_request
        shop_item = ShopItem.last
        expect(JSON.parse(response.body)['shop_item']).to include("name" => "food")
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:shop_item, name: nil) }

      it { expect { call_request }.not_to change { ShopItem.count } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#update' do
    let!(:shop_item) { create(:shop_item, name: 'name') }
    let(:call_request) { put :update, shop_item: attributes, id: shop_item }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { shop_item.reload.name }.from('name').to('test') }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)['shop_item']).to include("name" => "test")
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { shop_item.reload.name } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: shop_item }
    let!(:shop_item) { create(:shop_item) }

    it { expect { call_request }.to change { ShopItem.count }.by(-1) }
    it 'returns message' do
      call_request
      expect(JSON.parse(response.body)).to eq("message"=>"shop item destroyed")
    end
  end
end

