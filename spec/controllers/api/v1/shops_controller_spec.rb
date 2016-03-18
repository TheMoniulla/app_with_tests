require 'rails_helper'

describe Api::V1::ShopsController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let!(:shop) { create(:shop, name: 'Delima') }
    let(:call_request) { get :index }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)['shops'].count).to eq 1
      expect(JSON.parse(response.body)['shops'].first).to include("name" => "Delima")
    end
  end

  describe '#show' do
    let!(:shop) { create(:shop, name: "Delima") }
    let(:call_request) { get :show, id: shop }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)).to eq("shop" => {"name"=>"Delima"})
    end
  end

  describe '#create' do
    let(:call_request) { post :create, shop: attributes }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:shop, name: "Delima") }

      it { expect { call_request }.to change { Shop.count }.by 1 }

      it 'returns correct json' do
        call_request
        shop = Shop.last
        expect(JSON.parse(response.body)).to eq("shop" => {"name" => "Delima"})
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:shop, name: nil) }

      it { expect { call_request }.not_to change { Shop.count } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#update' do
    let!(:shop) { create(:shop, name: 'name') }
    let(:call_request) { put :update, shop: attributes, id: shop }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { shop.reload.name }.from('name').to('test') }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("shop" => {"name" => "test"})
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { shop.reload.name } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: shop }
    let!(:shop) { create(:shop) }

    it { expect { call_request }.to change { Shop.count }.by(-1) }
    it 'returns message' do
      call_request
      expect(JSON.parse(response.body)).to eq("message"=>"shop destroyed")
    end
  end
end
