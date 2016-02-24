require 'rails_helper'

describe Currency do
  it('has valid factory') { expect(build(:currency)).to be_valid }
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to have_many :expenses }
end