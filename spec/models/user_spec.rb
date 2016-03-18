require 'rails_helper'

describe User do
  it('has valid factory') { expect(build(:user)).to be_valid }
  it { is_expected.to have_many(:expenses) }
  it { is_expected.to have_many(:groups).through(:memberships) }
  it { is_expected.to have_many(:identities) }
  it { is_expected.to have_many(:memberships).inverse_of(:user) }
  it { is_expected.to have_many(:shop_items) }
  it { is_expected.to have_many(:owned_groups).class_name('Group').with_foreign_key(:owner_id) }
end
