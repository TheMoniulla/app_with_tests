require 'rails_helper'

describe Api::V1::ExpensesCategoriesController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let!(:expenses_category) { create(:expenses_category, name: "name") }
    let(:call_request) { get :index }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)['expenses_categories'].count).to eq 1
      expect(JSON.parse(response.body)['expenses_categories'].first).to include('name' => 'name')
    end
  end

  describe '#show' do
    let!(:expenses_category) { create(:expenses_category, name: 'name') }
    let(:call_request) { get :show, id: expenses_category }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)['expenses_category']).to include("name" => "name")
    end
  end

  describe '#create' do
    let(:call_request) { post :create, expenses_category: attributes }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:expenses_category, name: 'food') }

      it { expect { call_request }.to change { ExpensesCategory.count }.by 1 }

      it 'returns correct json' do
        call_request
        expenses_category = ExpensesCategory.last
        expect(JSON.parse(response.body)['expenses_category']).to include("name" => "food")
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:expenses_category, name: nil) }

      it { expect { call_request }.not_to change { ExpensesCategory.count } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#update' do
    let!(:expenses_category) { create(:expenses_category, name: 'name') }
    let(:call_request) { put :update, expenses_category: attributes, id: expenses_category }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { expenses_category.reload.name }.from('name').to('test') }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)['expenses_category']).to include("name" => "test")
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { expenses_category.reload.name } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: expenses_category }
    let!(:expenses_category) { create(:expenses_category) }

    it { expect { call_request }.to change { ExpensesCategory.count }.by(-1) }
    it 'returns message' do
      call_request
      expect(JSON.parse(response.body)).to eq("message"=>"expenses category destroyed")
    end
  end
end
