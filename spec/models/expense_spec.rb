require 'rails_helper'

describe Expense do
  it('has valid factory') { expect(build(:expense)).to be_valid }

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to belong_to(:expenses_category) }
  it { is_expected.to belong_to(:shop) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of :currency_id }
  it { is_expected.to validate_presence_of :expenses_category_id }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :price_value }
  it { is_expected.to validate_presence_of :shop_id }
  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to validate_attachment_content_type(:photo).allowing("image/jpg", "image/jpeg", "image/png", "image/gif")}
end
