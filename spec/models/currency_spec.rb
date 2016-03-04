require 'rails_helper'

describe Currency do
  it('has valid factory') { expect(build(:currency)).to be_valid }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :expenses }
end
