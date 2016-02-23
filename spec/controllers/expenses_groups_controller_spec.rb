require 'rails_helper'

describe ExpensesGroupsController do
  describe '#index' do
    let(:call_request) { get :index }
    let!(:expenses_group) { create(:expenses_group) }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
      it { expect(assigns(:expenses_groups)).to eq [expenses_group] }
    end
  end
end
