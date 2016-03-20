require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe User::WeeklyExpensesController do
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
  end

  context 'user logged in' do
    before { sign_in(user) }

    describe '#index' do
      context 'html' do
        let(:call_request) { get :index }

        context 'after request' do
          before { call_request }
          it { is_expected.to render_template 'index' }
        end

        context 'weekly expenses exist' do
          before do
            travel_to Time.parse("2016-03-18 10:10")
            create(:expense, name: 'ex1', user: user)
            create(:expense, name: 'ex2', user: user, created_at: 2.weeks.ago)
            create(:expense, name: 'ex3')
            call_request
          end

          it { expect(response.body).to include('ex1') }
          it { expect(response.body).not_to include('ex2') }
          it { expect(response.body).not_to include('ex3') }
        end
      end
    end

    context 'pdf' do
      let(:call_request) { get :index, format: 'pdf' }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'index' }
      end
    end
  end
end
