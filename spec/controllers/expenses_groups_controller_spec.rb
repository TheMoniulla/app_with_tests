require 'rails_helper'

describe ExpensesGroupsController do
  before { sign_in(create(:user)) }

  describe '#create' do
    let(:expenses_group) { create(:expenses_group) }
    let(:call_request) { post :create, expenses_group: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:currency, name: 'name', description: 'description') }

      it { expect { call_request }.to change { ExpensesGroup.count }.by(1) }
    end
  end
end
