require 'rails_helper'

describe ExpensesCategory do
  it('has valid factory') { expect(build(:expenses_category)).to be_valid }
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to have_many :expenses }

  describe '#total_price_for_user' do
    let(:expenses_category) { create(:expenses_category) }
    let!(:user) { create(:user) }
    let!(:expense_1) { create(:expense, price_value: 12.2, expenses_category: expenses_category, user: user) }
    let!(:expense_2) { create(:expense, price_value: 32.2, expenses_category: expenses_category, user: user) }

    it 'returns total expenses for user' do
      expect(expenses_category.total_price_for_user(user)).to eq 44.4
    end
  end
end
