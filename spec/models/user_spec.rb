require 'rails_helper'

describe User do
  it('has valid factory') { expect(build(:user)).to be_valid }
  it { is_expected.to have_many(:expenses) }
end
