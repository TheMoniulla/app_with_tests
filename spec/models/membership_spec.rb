require 'rails_helper'

describe Membership do
  it('has valid factory') { expect(build(:membership)).to be_valid }
  it { is_expected.to belong_to(:group).inverse_of(:memberships) }
  it { is_expected.to belong_to(:user).inverse_of(:memberships) }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :group }
end
