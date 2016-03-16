require 'rails_helper'

describe User::GroupsExpensesController do
  let(:user) { create(:user) }

  context 'user not logged in' do
    describe 'index' do
      let(:call_request) { get :index }

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
      let(:report) { create(:report) }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'index' }
      end
    end
  end
end
