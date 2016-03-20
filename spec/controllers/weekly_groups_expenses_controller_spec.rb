require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe User::WeeklyGroupsExpensesController do
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

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'index' }
      end

      context 'group expenses exist' do
        before do
          create(:group, name: 'gr1', owner: user, users: [user])
          create(:group, name: 'gr2')
          call_request
        end

        it { expect(response.body).to include('gr1') }
        it { expect(response.body).not_to include('gr2') }
      end
    end

    describe '#show' do
      let(:call_request) { get :show, id: group.id }
      let(:user_2) { create(:user) }
      let(:user_3) { create(:user) }
      let!(:group) { create(:group, owner: user, users: [user, user_2]) }

      context 'html' do
        before do
          travel_to Time.parse("2016-03-18 10:10")
          create(:expense, name: 'ex1', user: user)
          create(:expense, name: 'ex2', user: user_2)
          create(:expense, name: 'ex3', user: user, created_at: 2.weeks.ago)
          create(:expense, name: 'ex4', user: user_3)
          call_request
        end

        it { is_expected.to render_template 'show' }

        it 'displays correct expenses' do
          expect(response.body).to include('ex1')
          expect(response.body).to include('ex2')
          expect(response.body).not_to include('ex3')
          expect(response.body).not_to include('ex4')
        end
      end

      context 'pdf' do
        let(:call_request) { get :show, id: group.id, format: 'pdf' }

        context 'after request' do
          before { call_request }
          it { is_expected.to render_template 'show' }
        end
      end
    end
  end
end
