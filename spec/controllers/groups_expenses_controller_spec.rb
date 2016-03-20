require 'rails_helper'

describe User::GroupsExpensesController do
  render_views

  let(:user) { create(:user) }

  context 'user not logged in' do
    describe '#index' do
      let(:call_request) { get :index }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#show' do
      let(:call_request) { get :show, id: group.id }
      let!(:group) { create(:group) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  context 'user logged in' do
    before { sign_in(user) }

    describe '#index' do
      let(:call_request) { get :index }

      it "renders index" do
        call_request
        is_expected.to render_template 'index'
      end

      context 'groups exist' do
        let!(:group_1) {create(:group, name: 'gr1', owner: user, users: [user])}
        let!(:group_2) {create(:group, name: 'gr2')}
        before { call_request }

        it { expect(response.body).to include('gr1') }
        it { expect(response.body).not_to include('gr2') }
      end
    end

    describe '#show' do
      let(:call_request) { get :show, id: group.id }
      let(:user_2) { create(:user) }
      let(:user_3) { create(:user) }
      let!(:group) { create(:group, owner: user, users: [user, user_2]) }
      let!(:expense_1) { create(:expense, name: 'ex1', user: user) }
      let!(:expense_2) { create(:expense, name: 'ex2', user: user_2) }
      let!(:expense_3) { create(:expense, name: 'ex3', user: user_3) }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'show' }

        it 'displays correct expenses' do
          expect(response.body).to include('ex1')
          expect(response.body).to include('ex2')
          expect(response.body).not_to include('ex3')
        end
      end
    end
  end
end
