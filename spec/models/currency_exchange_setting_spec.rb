require 'rails_helper'

describe CurrencyExchangeSetting do
  it('has valid factory') { expect(build(:currency_exchange_setting)).to be_valid }
  it { is_expected.to validate_presence_of :value }
  it { is_expected.to validate_presence_of :base_currency }
  it { is_expected.to validate_presence_of :new_currency }
end
