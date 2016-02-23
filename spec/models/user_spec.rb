require 'rails_helper'

describe User do
  it('has valid factory') { expect(build(:user)).to be_valid }

  it { should have_many(:expenses) }

  describe '#expenses_by_week' do
    let(:user) { create(:user) }
    let!(:expense_1) { create(:expense, user: user, created_at: Date.parse('2016-02-18')) }
    let!(:expense_2) { create(:expense, user: user, created_at: Date.parse('2016-02-23')) }
    let!(:expense_3) { create(:expense, created_at: Date.parse('2016-02-23')) }

    it 'grouped expenses by week' do
      expect(user.expenses_by_week).to eq({'2016-02-15 - 2016-02-21' => [expense_1],
                                           "2016-02-22 - 2016-02-28" => [expense_2]})
    end
  end
end


