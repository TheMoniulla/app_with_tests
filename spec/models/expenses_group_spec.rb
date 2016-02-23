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

end