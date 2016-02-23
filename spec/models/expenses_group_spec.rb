require 'rails_helper'

describe ExpensesGroup do
  it('has valid factory') { expect(build(:expenses_group)).to be_valid }

  it { should validate_presence_of(:name) }

  it { should have_many(:expenses) }

end