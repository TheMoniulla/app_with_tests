require 'rails_helper'

describe User do
  it('has valid factory') { expect(build(:user)).to be_valid }

  it { should have_many(:expenses) }

end
