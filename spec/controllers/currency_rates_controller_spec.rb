require 'rails_helper'

describe CurrencyRatesController do
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
      let(:call_request) { get :index }
      let!(:currency_1) { create(:currency, name: 'USD')}
      let!(:currency_2) { create(:currency, name: 'EUR')}
      let!(:currency_rate_1) { create(:currency_rate, currency_id: currency_1.id ) }
      let!(:currency_rate_2) { create(:currency_rate, currency_id: currency_2.id ) }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'index' }
        it { expect(controller.eur_currency_rates).to eq [currency_rate_2] }
        it { expect(controller.usd_currency_rates).to eq [currency_rate_1] }
        it { expect(controller.eur_chart_data).to eq [currency_rate_2].map(&:for_chart) }
        it { expect(controller.usd_chart_data).to eq [currency_rate_1].map(&:for_chart) }
      end
    end
  end
end
