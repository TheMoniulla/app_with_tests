require 'rails_helper'

describe Shop do
  it('has valid factory') { expect(build(:shop)).to be_valid }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to have_many :expenses }
end
