require 'rails_helper'

describe User::ShopItemsController do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    let(:call_request) { get :index }
    let(:shop_item) { create(:shop_item, user: user) }

    context 'after request' do
      before { call_request }
      it { is_expected.to render_template 'index' }
      it { expect(controller.shop_items).to eq [shop_item] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { is_expected.to render_template 'new' }
      it { expect(controller.shop_item.persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: shop_item.id }

    context 'shop_item for logged in user' do
      let(:shop_item) { create(:shop_item, user: user) }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'edit' }
        it { expect(controller.shop_item).to eq shop_item }
      end
    end

    context 'shop_item for not logged in user' do
      let(:shop_item) { create(:shop_item) }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_shop_items_path }
      end
    end
  end

  describe '#create' do
    let(:call_request) { post :create, shop_item: attributes }

    context 'a request has valid params' do
      let(:attributes) do
        attributes_for(:shop_item, name: 'name', user: user)
      end

      it { expect { call_request }.to change { ShopItem.count }.by(1) }

      context 'after request' do
        before { call_request }
        let(:shop_item) { ShopItem.last }

        it { is_expected.to redirect_to user_shop_items_path }
        it { expect(shop_item.name).to eq 'name' }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:shop_item, name: nil) }
      it { expect { call_request }.not_to change { ShopItem.count } }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:shop_item) { create(:shop_item, name: 'name', user: user) }
    let(:call_request) { put :update, shop_item: attributes, id: shop_item.id }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { shop_item.reload.name }.from('name').to('test') }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_shop_items_path }
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { shop_item.reload.name } }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: shop_item.id, user: user }

    context 'shop_item for logged in user' do
      let!(:shop_item) { create(:shop_item, user: user) }

      it { expect { call_request }.to change { ShopItem.count }.by(-1) }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_shop_items_path }
      end
    end

    context 'shop_item for not logged in user' do
      let!(:shop_item) { create(:shop_item) }

      it { expect { call_request }.not_to change { ShopItem.count } }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to user_shop_items_path }
      end
    end
  end
end
