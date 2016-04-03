require 'rails_helper'

describe CurrencyRate do
  it('has valid factory') { expect(build(:currency_rate)).to be_valid }
  it { is_expected.to validate_presence_of :rate }
  it { is_expected.to validate_presence_of :currency_id }
  it { is_expected.to belong_to(:currency) }
end
