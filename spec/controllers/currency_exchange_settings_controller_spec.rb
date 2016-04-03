require 'rails_helper'

describe CurrencyExchangeSettingsController do
  render_views

  context 'user not logged in' do
    describe '#create' do
      let(:currency_exchange_setting) { create(:currency_exchange_setting) }
      let(:call_request) { post :create, currency_exchange_setting: attributes }
      let(:attributes) { attributes_for(:currency_exchange_setting, value: 'name') }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#destroy' do
      let(:call_request) { delete :destroy, id: currency_exchange_setting.id }
      let!(:currency_exchange_setting) { create(:currency_exchange_setting) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  context 'user logged in' do
    before { sign_in(create(:user)) }

    describe '#create' do
      let(:currency_exchange_setting) { create(:currency_exchange_setting) }
      let(:call_request) { post :create, currency_exchange_setting: attributes }

      context 'a request has valid params' do
        let(:attributes) { attributes_for(:currency_exchange_setting, value: 345, base_currency: 'PLN', new_currency: 'EUR') }

        it { expect { call_request }.to change { CurrencyExchangeSetting.count }.by(1) }
        context 'after request' do
          before { call_request }
          let(:currency_exchange_setting) { CurrencyExchangeSetting.last }

          it { is_expected.to redirect_to currency_exchange_index_path }
          it { expect(currency_exchange_setting.value).to eq 345 }
          it { expect(currency_exchange_setting.base_currency).to eq 'PLN' }
          it { expect(currency_exchange_setting.new_currency).to eq 'EUR' }
        end
      end

      describe '#destroy' do
        let!(:currency_exchange_setting) { create(:currency_exchange_setting) }
        let(:call_request) { delete :destroy, id: currency_exchange_setting.id }

        it 'destroy currency_exchange_setting' do
          expect { call_request }.to change { CurrencyExchangeSetting.count }.by(-1)
        end

        it 'redirects to currency_exchange_index_path' do
          call_request
          is_expected.to redirect_to currency_exchange_index_path
        end
      end
    end
  end
end
