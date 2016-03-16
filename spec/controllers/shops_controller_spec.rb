require 'rails_helper'

describe ShopsController do

  context 'user not logged in' do
    describe 'index' do
      let(:call_request) { get :index }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#new' do
      let(:call_request) { get :new }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe 'edit' do
      let(:call_request) { get :edit, id: shop.id }
      let(:shop) { create(:shop) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#create' do
      let(:shop) { create(:shop) }
      let(:call_request) { post :create, shop: attributes }
      let(:attributes) { attributes_for(:shop, name: 'name') }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#update' do
      let!(:shop) { create(:shop, name: 'name') }
      let(:call_request) { put :update, shop: attributes, id: shop.id }
      let(:attributes) { {name: 'test'} }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#destroy' do
      let(:call_request) { delete :destroy, id: shop.id }
      let!(:shop) { create(:shop) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  context 'user logged in' do

    before { sign_in(create(:user)) }

    describe '#index' do
      let(:call_request) { get :index }
      let(:shop) { create(:shop, name: 'name') }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'index' }
        it { expect(controller.shops).to eq [shop] }
      end
    end

    describe '#new' do
      let(:call_request) { get :new }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'new' }
        it { expect(controller.shop.persisted?).to be false }
      end
    end

    describe '#edit' do
      let(:call_request) { get :edit, id: shop.id }
      let(:shop) { create(:shop) }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'edit' }
        it { expect(controller.shop).to eq shop }
      end
    end

    describe '#create' do
      let(:shop) { create(:shop) }
      let(:call_request) { post :create, shop: attributes }

      context 'a request has valid params' do
        let(:attributes) { attributes_for(:currency, name: 'name') }

        it { expect { call_request }.to change { Shop.count }.by(1) }
        context 'after request' do
          before { call_request }
          let(:shop) { Shop.last }

          it { is_expected.to redirect_to shops_path }
          it { expect(shop.name).to eq 'name' }
        end
      end

      context 'a request has invalid params' do
        let(:attributes) { attributes_for(:shop, name: nil) }
        it { expect { call_request }.not_to change { Shop.count } }

        context 'after request' do
          before { call_request }
          it { is_expected.to render_template 'new' }
        end
      end
    end

    describe '#update' do
      let!(:shop) { create(:shop, name: 'name') }
      let(:call_request) { put :update, shop: attributes, id: shop.id }

      context 'a request has valid params' do
        let(:attributes) { {name: 'test'} }

        it { expect { call_request }.to change { shop.reload.name }.from('name').to('test') }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to shops_path }
        end
      end

      context 'a request has invalid params' do
        let(:attributes) { {name: nil} }

        it { expect { call_request }.not_to change { shop.reload.name } }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'edit' }
        end
      end
    end

    describe '#destroy' do
      let(:call_request) { delete :destroy, id: shop.id }
      let!(:shop) { create(:shop) }

      it { expect { call_request }.to change { Shop.count }.by(-1) }

      context 'after request' do
        before { call_request }

        it { is_expected.to redirect_to shops_path }
      end
    end
  end
end
