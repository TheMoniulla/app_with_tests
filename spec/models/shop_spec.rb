require 'rails_helper'

describe Shop do
  it('has valid factory') { expect(build(:shop)).to be_valid }

  it { expect(subject).to validate_presence_of :name }

  it { expect(subject).to have_many :expenses }

  describe '#to_s' do
    let(:shop) { create(:shop, name: 'name') }

    it 'display shop name' do
      expect(shop.to_s).to eq 'name'
    end
  end
end