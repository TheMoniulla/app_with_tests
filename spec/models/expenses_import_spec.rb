require 'rails_helper'

describe ExpensesImport do
  describe '#import_for' do
    let(:user) { create(:user) }

    let(:file) { double }
    let(:perform) { described_class.new(file).import_for(user) }

    before do
      create(:currency, name: 'PLN')
      create(:shop, name: 'H&M')
      create(:shop, name: 'Tesco')
      create(:shop, name: 'Rossmann')
      create(:expenses_category, name: 'Clothes and Shoes')
      create(:expenses_category, name: 'Toys')
      create(:expenses_category, name: 'Food')
      allow(file).to receive(:original_filename).and_return('expenses.ods')
      allow(file).to receive(:path).and_return([Rails.root, 'spec/fixtures/files/expenses.ods'].join('/'))
    end

    it 'imports expenses' do
      expect { perform }.to change { Expense.count }.by(4)
    end
  end
end
