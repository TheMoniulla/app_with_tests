require 'rails_helper'

describe User::GroupsExpensesController do
  let(:user) { create(:user) }
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
