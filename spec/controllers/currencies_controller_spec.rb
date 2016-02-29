require 'rails_helper'

describe CurrenciesController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let(:call_request) { get :index }
    let(:currency) { create(:currency, name: 'name') }

    context 'after request' do
      before { call_request }
      it { is_expected.to render_template 'index' }
      it { expect(controller.currencies).to eq [currency] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { is_expected.to render_template 'new' }
      it { expect(controller.currency.persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: currency.id }
    let(:currency) { create(:currency) }

    context 'after request' do
      before { call_request }

      it { is_expected.to render_template 'edit' }
      it { expect(controller.currency).to eq currency }
    end
  end

  describe '#create' do
    let(:currency) { create(:currency) }
    let(:call_request) { post :create, currency: attributes }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:currency, name: 'name') }

      it { expect { call_request }.to change { Currency.count }.by(1) }
      context 'after request' do
        before { call_request }
        let(:currency) { Currency.last }

        it { is_expected.to redirect_to currencies_path }
        it { expect(currency.name).to eq 'name' }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:currency, name: nil) }
      it { expect { call_request }.not_to change { Currency.count } }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:currency) { create(:currency, name: 'name') }
    let(:call_request) { put :update, currency: attributes, id: currency.id }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { currency.reload.name }.from('name').to('test') }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to currencies_path }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { currency.reload.name } }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: currency.id }
    let!(:currency) { create(:currency) }

    it { expect { call_request }.to change { Currency.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { is_expected.to redirect_to currencies_path }
    end
  end
end


