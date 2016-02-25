require 'rails_helper'

describe CurrenciesController do
  before { sign_in(create(:user)) }

  describe '#create' do
    let(:currency) { create(:currency) }
    let(:call_request) { post :create, currency: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:currency, name: 'name') }

      it { expect { call_request }.to change { Currency.count }.by(1) }
    end
  end
end
