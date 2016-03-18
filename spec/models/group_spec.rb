require 'rails_helper'

describe Group do
  it('has valid factory') { expect(build(:group)).to be_valid }
  it { is_expected.to have_many(:users).through(:memberships) }
  it { is_expected.to have_many(:memberships).inverse_of(:group) }
  it { is_expected.to belong_to(:owner).class_name('User') }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:owner_id).with_message('This group already exists!') }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :owner_id }
end
