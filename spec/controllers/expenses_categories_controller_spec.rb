require 'rails_helper'

describe ExpensesCategoriesController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let(:call_request) { get :index }
    let(:expenses_category) { create(:expenses_category, name: 'name', description: 'description') }

    context 'after request' do
      before { call_request }
      it { is_expected.to render_template 'index' }
      it { expect(controller.expenses_categories).to eq [expenses_category] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { is_expected.to render_template 'new' }
      it { expect(controller.expenses_category.persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: expenses_category.id }
    let(:expenses_category) { create(:expenses_category) }

    context 'after request' do
      before { call_request }

      it { is_expected.to render_template 'edit' }
      it { expect(controller.expenses_category).to eq expenses_category }
    end
  end

  describe '#create' do
    let(:expenses_category) { create(:expenses_category) }
    let(:call_request) { post :create, expenses_category: attributes }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:expenses_category, name: 'name', description: 'description') }

      it { expect { call_request }.to change { ExpensesCategory.count }.by(1) }
      context 'after request' do
        before { call_request }
        let(:expenses_category) { ExpensesCategory.last }

        it { is_expected.to redirect_to expenses_categories_path }
        it { expect(expenses_category.name).to eq 'name' }
        it { expect(expenses_category.description).to eq 'description' }
      end
    end
    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:expenses_category, name: nil) }
      it { expect { call_request }.not_to change { ExpensesCategory.count } }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:expenses_category) { create(:expenses_category, name: 'name', description: 'description') }
    let(:call_request) { put :update, expenses_category: attributes, id: expenses_category.id }

    context 'a request has valid params' do
      let(:attributes) { {name: 'name', description: 'test'} }

      it { expect { call_request }.not_to change { expenses_category.reload.name } }
      it { expect { call_request }.to change { expenses_category.reload.description }.from('description').to('test') }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to expenses_categories_path }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { expenses_category.reload.name } }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: expenses_category.id }
    let!(:expenses_category) { create(:expenses_category) }

    it { expect { call_request }.to change { ExpensesCategory.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { is_expected.to redirect_to expenses_categories_path }
    end
  end
end
