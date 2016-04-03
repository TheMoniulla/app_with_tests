require 'rails_helper'

describe CurrencyExchangeController do
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

    context 'html' do
      describe '#index' do
        let(:call_request) { get :index }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'index' }
          it { expect(controller.pln_money).to eq Money.new(1_00, 'PLN') }
          it { expect(controller.eur_money).to eq Money.new(1_00, 'EUR') }
          it { expect(controller.usd_money).to eq Money.new(1_00, 'USD') }
        end

        context 'currency exchange setting exists' do
          before do
            create(:currency_exchange_setting, value: 888.88)
            call_request
          end

          it 'expect to display currency exchange settings' do
            expect(response.body).to include '888.88'
          end
        end
      end
    end

    context 'JSON' do
      describe '#index' do
        let(:call_request) { get :index, format: :json, value: 16, base_currency: 'PLN', new_currency: 'USD' }
        before { allow_any_instance_of(Money).to receive(:exchange_to).with('USD').and_return(4.0) }

        it 'returns correct json' do
          call_request
          expect(JSON.parse(response.body)).to eq({"converted_value" => 400})
        end
      end
    end
  end
end
