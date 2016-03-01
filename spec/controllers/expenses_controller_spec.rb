require 'rails_helper'

describe User::ExpensesController do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    let(:call_request) { get :index }
    let(:expense) { create(:expense, user: user) }

    context 'after request' do
      before { call_request }
      it { is_expected.to render_template 'index' }
      it { expect(controller.expenses).to eq [expense] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { is_expected.to render_template 'new' }
      it { expect(controller.expense.persisted?).to be false }
    end
  end

  describe '#show' do
    let(:call_request) { get :show, id: expense.id }

    context 'expense for logged in user' do
      let!(:expense) { create(:expense, user: user) }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'show' }
        it { expect(controller.expense).to eq expense }
      end
    end

    context 'expense not for logged in user' do
      let(:expense) { create(:expense) }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_expenses_path }
      end
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: expense.id }

    context 'expense for logged in user' do
      let(:expense) { create(:expense, user: user) }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'edit' }
        it { expect(controller.expense).to eq expense }
      end
    end

    context 'expense not for logged in user' do
      let(:expense) { create(:expense) }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_expenses_path }
      end
    end
  end

  describe '#create' do
    let(:call_request) { post :create, expense: attributes }

    context 'a request has valid params' do
      let(:attributes) do
        attributes_for(:expense, name: 'name', user: user)
      end

      it { expect { call_request }.to change { Expense.count }.by(1) }

      context 'after request' do
        before { call_request }
        let(:expense) { Expense.last }

        it { is_expected.to redirect_to user_expenses_path }
        it { expect(expense.name).to eq 'name' }
        it { expect(expense.description).to eq 'description' }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:expense, name: nil) }
      it { expect { call_request }.not_to change { Expense.count } }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:expense) { create(:expense, name: 'name', user: user) }
    let(:call_request) { put :update, expense: attributes, id: expense.id }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { expense.reload.name }.from('name').to('test') }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_expenses_path }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { expense.reload.name } }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: expense.id, user: user }

    context 'expense for logged in user' do
      let!(:expense) { create(:expense, user: user) }

      it { expect { call_request }.to change { Expense.count }.by(-1) }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_expenses_path }
      end
    end

    context 'expense not for logged in user' do
      let!(:expense) { create(:expense) }

      it { expect { call_request }.not_to change { Expense.count } }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_expenses_path }
      end
    end
  end
end
