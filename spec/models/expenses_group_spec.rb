require 'rails_helper'

describe ExpensesGroup do
  it('has valid factory') { expect(build(:expenses_group)).to be_valid }

  it { expect(subject).to validate_presence_of :name }

  it { expect(subject).to have_many :expenses }

  describe '#to_s' do
    let(:expenses_group) { create(:expenses_group, name: 'name') }

    it 'display shop name' do
      expect(expenses_group.to_s).to eq 'name'
    end
  end

  describe '#expenses_for_user' do
    let(:expenses_group) { create(:expenses_group) }
    let!(:user) { create(:user) }
    let!(:expense_1) { create(:expense, expenses_group: expenses_group, user: user) }
    let!(:expense_2) { create(:expense, expenses_group: expenses_group) }

    it 'returns expenses for user' do
      expect(expenses_group.expenses_for_user(user)).to eq [expense_1]
    end
  end

  describe '#total_price_for_user' do
    let(:expenses_group) { create(:expenses_group) }
    let!(:user) { create(:user) }
    let!(:expense_1) { create(:expense, price_value: 12.2, expenses_group: expenses_group, user: user) }
    let!(:expense_2) { create(:expense, price_value: 32.2, expenses_group: expenses_group, user: user) }

    it 'returns total expenses for user' do
      expect(expenses_group.total_price_for_user(user)).to eq 44.4
    end
  end
end