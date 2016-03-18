require 'rails_helper'

describe Api::V1::ExpensesController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let!(:expense) { create(:expense, name: "name") }
    let(:call_request) { get :index }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)['expenses'].count).to eq 1
      expect(JSON.parse(response.body)['expenses'].first).to include('name' => 'name')
    end
  end

  describe '#show' do
    let!(:expense) { create(:expense, name: 'name') }
    let(:call_request) { get :show, id: expense }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)['expense']).to include("name" => "name")
    end
  end

  describe '#create' do
    let(:call_request) { post :create, expense: attributes }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:expense, name: 'food') }

      it { expect { call_request }.to change { Expense.count }.by 1 }

      it 'returns correct json' do
        call_request
        expense = Expense.last
        expect(JSON.parse(response.body)['expense']).to include("name" => "food")
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:expense, name: nil) }

      it { expect { call_request }.not_to change { Expense.count } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#update' do
    let!(:expense) { create(:expense, name: 'name') }
    let(:call_request) { put :update, expense: attributes, id: expense }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { expense.reload.name }.from('name').to('test') }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)['expense']).to include("name" => "test")
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { expense.reload.name } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: expense }
    let!(:expense) { create(:expense) }

    it { expect { call_request }.to change { Expense.count }.by(-1) }
    it 'returns message' do
      call_request
      expect(JSON.parse(response.body)).to eq("message"=>"expense destroyed")
    end
  end
end

