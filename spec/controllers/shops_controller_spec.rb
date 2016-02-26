require 'rails_helper'

describe ShopsController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let(:call_request) { get :index }
    let(:shop) { create(:shop, name: 'name') }

    context 'after request' do
      before { call_request }
      it { should render_template 'index' }
      it { expect(controller.shops).to eq [shop] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(controller.shop.persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: shop.id }
    let(:shop) { create(:shop) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(controller.shop).to eq shop }
    end
  end

  describe '#create' do
    let(:shop) { create(:shop) }
    let(:call_request) { post :create, shop: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:currency, name: 'name') }

      it { expect { call_request }.to change { Shop.count }.by(1) }
      context 'after request' do
        before { call_request }
        let(:shop) { Shop.last }

        it { should redirect_to shops_path }
        it { expect(shop.name).to eq 'name' }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:shop, name: nil) }
      it { expect { call_request }.not_to change { Shop.count } }

      context 'after request' do
        before { call_request }
        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:shop) { create(:shop, name: 'name') }
    let(:call_request) { put :update, shop: attributes, id: shop.id }

    context 'valid request' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { shop.reload.name }.from('name').to('test') }

      context 'after request' do
        before { call_request }

        it { should redirect_to shops_path }
      end
    end

    context 'invalid request' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { shop.reload.name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: shop.id }
    let!(:shop) { create(:shop) }

    it { expect { call_request }.to change { Shop.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to shops_path }
    end
  end
end