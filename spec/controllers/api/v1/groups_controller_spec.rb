require 'rails_helper'

describe Api::V1::GroupsController do
  before { sign_in(create(:user)) }

  describe '#index' do
    let(:user) { create (:user) }
    let!(:group) { create(:group, name: 'Family', owner_id: user.id) }
    let(:call_request) { get :index }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)).to eq("groups" => [{"name"=>"Family", "owner_id"=>user.id}])
    end
  end

  describe '#show' do
    let(:user) { create (:user) }
    let!(:group) { create(:group, name: "Family", owner_id: user.id) }
    let(:call_request) { get :show, id: group }

    it 'returns correct json' do
      call_request
      expect(JSON.parse(response.body)).to eq("group" => {"name"=>"Family", "owner_id"=>user.id})
    end
  end

  describe '#create' do
    let(:call_request) { post :create, group: attributes }
    let(:user) { create(:user) }

    context 'a request has valid params' do
      let(:attributes) { attributes_for(:group, name: "Family", owner_id: user.id) }

      it { expect { call_request }.to change { Group.count }.by 1 }

      it 'returns correct json' do
        call_request
        group = Group.last
        expect(JSON.parse(response.body)).to eq("group" => {"name" => "Family", "owner_id"=>user.id})
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { attributes_for(:group, name: nil) }

      it { expect { call_request }.not_to change { Group.count } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let!(:group) { create(:group, name: 'name', owner_id: user.id) }
    let(:call_request) { put :update, group: attributes, id: group }

    context 'a request has valid params' do
      let(:attributes) { {name: 'test'} }

      it { expect { call_request }.to change { group.reload.name }.from('name').to('test') }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("group" => {"name" => "test", "owner_id"=>user.id})
      end
    end

    context 'a request has invalid params' do
      let(:attributes) { {name: nil} }

      it { expect { call_request }.not_to change { group.reload.name } }

      it 'returns correct json' do
        call_request
        expect(JSON.parse(response.body)).to eq("errors" => {"name" => ["can't be blank"]})
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: group }
    let!(:group) { create(:group) }

    it { expect { call_request }.to change { Group.count }.by(-1) }
    it 'returns message' do
      call_request
      expect(JSON.parse(response.body)).to eq("message"=>"group destroyed")
    end
  end
end
