require 'rails_helper'

describe ShopItem do
  it('has valid factory') { expect(build(:shop_item)).to be_valid }

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to belong_to(:expenses_category) }
  it { is_expected.to belong_to(:shop) }
  it { is_expected.to belong_to(:user) }

  it { expect(subject).to validate_presence_of :currency_id }
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_presence_of :price_value }
  it { expect(subject).to validate_presence_of :purchased_on}
  it { expect(subject).to validate_presence_of :user_id }
end
