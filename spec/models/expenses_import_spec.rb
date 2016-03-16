require 'rails_helper'

describe ExpensesImport do
  describe '#import_for' do
    let(:user) { create(:user) }

    let(:file) { double }
    let(:perform) { described_class.new(file).import_for(user) }

    context 'correct file' do
      before do
        allow(file).to receive(:original_filename).and_return('expenses.ods')
        allow(file).to receive(:path).and_return([Rails.root, 'spec/fixtures/files/expenses.ods'].join('/'))
      end

      context 'all necessary data exists' do
        before do
          create(:shop, name: 'Rik')
          create(:currency, name: 'PLN')
          create(:expenses_category, name: 'Toys')
        end

        it 'imports expenses' do
          expect { perform }.to change { Expense.count }.by 2
        end
      end

      context 'necessary data does not exists' do
        context 'shop is missing' do

          it 'raise correct error' do
            expect { perform }.to raise_error(ExpensesImport::ImportError, "Shop with name 'Rik' was not found.")
          end
        end

        context 'currency is missing' do
          before { create(:shop, name: 'Rik') }

          it 'raise correct error' do
            expect { perform }.to raise_error(ExpensesImport::ImportError, "Currency with name 'PLN' was not found.")
          end
        end

        context 'currency is missing' do
          before do
            create(:shop, name: 'Rik')
            create(:currency, name: 'PLN')
          end

          it 'raise correct error' do
            expect { perform }.to raise_error(ExpensesImport::ImportError, "ExpensesCategory with name 'Toys' was not found.")
          end
        end
      end
    end

    context 'incorrect file' do
      before do
        allow(file).to receive(:original_filename).and_return('expenses_wrong.ods')
        allow(file).to receive(:path).and_return([Rails.root, 'spec/fixtures/files/expenses_wrong.ods'].join('/'))
      end

      context 'all necessary data exists' do
        before do
          create(:shop, name: 'Rik')
          create(:currency, name: 'PLN')
          create(:expenses_category, name: 'Toys')
        end

        it 'raise correct error' do
          expect { perform }.to raise_error(ExpensesImport::ImportError, "Validation failed: Price value can't be blank")
        end
      end
    end
  end
end
