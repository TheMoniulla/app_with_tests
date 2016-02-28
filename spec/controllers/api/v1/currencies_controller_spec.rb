require 'rails_helper'

describe Api::V1::CurrenciesController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let!(:currency) { create(:currency, name: 'PLN') }
    let(:call_request) { get :index }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)).to eq("currencies" => [{"id" => 1, "name" => "PLN"}])
    end
  end

  describe '#show' do
    let!(:currency) { create(:currency, name: "PLN") }
    let(:call_request) { get :show, id: currency.id }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)).to eq("currency" => {"id" => currency.id, "name" => "PLN"})
    end
  end

  describe '#create' do
    let(:call_request) { post :create, currency: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:currency, name: "PLN") }

      it { expect { call_request }.to change { Currency.count }.by 1 }

      it 'returns correct json' do
        call_request
        currency = Currency.last
        expect(JSON.parse(response.body)).to eq("currency" => {"id" => currency.id, "name" => "PLN"})
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:currency, name: nil) }

      it { expect { call_request }.not_to change { Currency.count } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#update' do
    let!(:currency) { create(:currency, name: 'name') }
    let(:call_request) { put :update, currency: attributes, id: currency.id }

    context 'valid request' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { currency.reload.name }.from('name').to('test') }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("currency" => {"id" => currency.id, "name" => "test"})
      end
    end

    context 'invalid request' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { currency.reload.name } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: currency.id }
    let!(:currency) { create(:currency) }

    it { expect { call_request }.to change { Currency.count }.by(-1) }
    it 'returns message' do
      call_request
      expect(JSON.parse(response.body)).to eq("message"=>"currency destroyed")
    end
  end
end

