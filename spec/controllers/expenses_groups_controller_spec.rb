require 'rails_helper'

describe ExpensesGroupsController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let(:call_request) { get :index }
    let(:expenses_group) { create(:expenses_group, name: 'name', description: 'description') }

    context 'after request' do
      before { call_request }
      it { should render_template 'index' }
      it { expect(controller.expenses_groups).to eq [expenses_group] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(controller.expenses_group.persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: expenses_group.id }
    let(:expenses_group) { create(:expenses_group) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(controller.expenses_group).to eq expenses_group }
    end
  end

  describe '#create' do
    let(:expenses_group) { create(:expenses_group) }
    let(:call_request) { post :create, expenses_group: attributes }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:expenses_group, name: 'name', description: 'description') }

      it { expect { call_request }.to change { ExpensesGroup.count }.by(1) }
      context 'after request' do
        before { call_request }
        let(:expenses_group) { ExpensesGroup.last }

        it { should redirect_to expenses_groups_path }
        it { expect(expenses_group.name).to eq 'name' }
        it { expect(expenses_group.description).to eq 'description' }
      end
    end
    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:expenses_group, name: nil) }
      it { expect { call_request }.not_to change { ExpensesGroup.count } }

      context 'after request' do
        before { call_request }
        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:expenses_group) { create(:expenses_group, name: 'name', description: 'description') }
    let(:call_request) { put :update, expenses_group: attributes, id: expenses_group.id }

    context 'a request has valid params' do
      let(:attributes) { {name: 'name', description: 'test'} }

      it { expect { call_request }.not_to change { expenses_group.reload.name } }
      it { expect { call_request }.to change { expenses_group.reload.description }.from('description').to('test') }

      context 'after request' do
        before { call_request }

        it { should redirect_to expenses_groups_path }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { expenses_group.reload.name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: expenses_group.id }
    let!(:expenses_group) { create(:expenses_group) }

    it { expect { call_request }.to change { ExpensesGroup.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to expenses_groups_path }
    end
  end
end
