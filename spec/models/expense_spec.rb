require 'rails_helper'

describe Expense do
  it('has valid factory') { expect(build(:expense)).to be_valid }

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to belong_to(:expenses_category) }
  it { is_expected.to belong_to(:shop) }
  it { is_expected.to belong_to(:user) }

  it { expect(subject).to validate_presence_of :currency_id }
  it { expect(subject).to validate_presence_of :expenses_category_id }
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_presence_of :price_value }
  it { expect(subject).to validate_presence_of :shop_id }
  it { expect(subject).to validate_presence_of :user_id }
end
