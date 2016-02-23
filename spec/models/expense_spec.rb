require 'rails_helper'

describe Expense do
  it('has valid factory') { expect(build(:expense)).to be_valid }

  it   { expect to belong_to(:expenses_group) }
  it { expect belong_to(:user) }
  it { expect belong_to(:shop) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:shop_id) }
  it { should validate_presence_of(:price_currency) }
  it { should validate_presence_of(:price_value) }
  it { should validate_presence_of(:expenses_group_id) }

end