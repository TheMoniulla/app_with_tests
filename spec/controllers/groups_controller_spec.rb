require 'rails_helper'

describe GroupsController do
  let(:user) { create (:user) }

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

    describe '#show' do
      let(:group) { create(:group) }
      let(:call_request) { get :show, id: group.id }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe 'edit' do
      let(:call_request) { get :edit, id: group.id }
      let(:group) { create(:group) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#create' do
      let(:group) { create(:group) }
      let(:call_request) { post :create, group: attributes }
      let(:attributes) { attributes_for(:group, name: 'name') }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#update' do
      let!(:group) { create(:group, name: 'name') }
      let(:call_request) { put :update, group: attributes, id: group.id }
      let(:attributes) { {name: 'test'} }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#destroy' do
      let(:call_request) { delete :destroy, id: group.id }
      let!(:group) { create(:group) }

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
      let(:user) { create (:user) }
      let(:group) { create(:group, name: 'name', owner_id: user.id) }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'index' }
        it { expect(controller.groups).to eq [group] }
      end
    end

    describe '#new' do
      let(:call_request) { get :new }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'new' }
        it { expect(controller.group.persisted?).to be false }
      end
    end

    describe '#show' do
      let(:call_request) { get :show, id: group.id }

      context 'group for logged in user' do
        let!(:user) { create (:user) }
        let!(:group) { create(:group, owner_id: user.id) }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'show' }
          it { expect(controller.group).to eq group }
        end
      end

      context 'group not for logged in user' do
        let(:group) { create(:group) }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to groups_path }
        end
      end
    end

    describe '#edit' do
      let(:call_request) { get :edit, id: group.id }

      context 'group for logged in user' do
        let(:group) { create(:group, owner_id: user.id) }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'edit' }
          it { expect(controller.group).to eq group }
        end
      end

      context 'group not for logged in user' do
        let(:group) { create(:group) }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to groups_path }
        end
      end
    end

    describe '#create' do
      let(:call_request) { post :create, group: attributes }

      context 'a request has valid params' do
        let!(:user) { create(:user) }
        let(:attributes) do
          attributes_for(:group, name: 'name', owner_id: user.id)
        end

        it { expect { call_request }.to change { Group.count }.by(1) }


        context 'after request' do

          before { call_request }
          let(:group) { Group.last }

          it { is_expected.to redirect_to groups_path }
          it { expect(group.name).to eq 'name' }
        end
      end

      context 'a request has invalid params' do
        let(:attributes) { attributes_for(:group, name: nil) }
        it { expect { call_request }.not_to change { Group.count } }

        context 'after request' do
          before { call_request }
          it { is_expected.to render_template 'new' }
        end
      end
    end

    describe '#update' do
      let!(:user) { create(:user) }
      let!(:group) { create(:group, name: 'name', owner_id: user.id) }
      let(:call_request) { put :update, group: attributes, id: group.id }

      context 'a request has valid params' do
        let(:attributes) { {name: 'test'} }

        it { expect { call_request }.to change { group.reload.name }.from('name').to('test') }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to groups_path }
        end
      end

      context 'a request has invalid params' do
        let(:attributes) { {name: nil} }

        it { expect { call_request }.not_to change { group.reload.name } }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'edit' }
        end
      end
    end
    describe '#destroy' do
      let(:call_request) { delete :destroy, id: group.id, owner_id: user.id }

      context 'group for logged in user' do
        let!(:group) { create(:group, owner_id: user.id) }

        it { expect { call_request }.to change { Group.count }.by(-1) }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to groups_path }
        end
      end

      context 'group not for logged in user' do
        let!(:group) { create(:group) }

        it { expect { call_request }.not_to change { Group.count } }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to groups_path }
        end
      end
    end
  end
end
