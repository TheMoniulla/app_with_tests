require 'rails_helper'

describe Currency do
  it('has valid factory') { expect(build(:currency)).to be_valid }
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to have_many :expenses }

  describe '#to_s' do
    let(:currency) { create(:currency, name: 'PLN') }

    it 'display shop name' do
      expect(currency.to_s).to eq 'PLN'
    end
  end
end