class ExpensesImport < Struct.new(:file)
  require 'roo'

  class ImportError < StandardError
  end

  def import_for(user)
    spreadsheet = open_spreadsheet(file)

    spreadsheet.default_sheet = spreadsheet.sheets.first
    (2..spreadsheet.last_row).each do |line|
      name = spreadsheet.cell(line, 'A')
      price = spreadsheet.cell(line, 'B')
      currency_name = spreadsheet.cell(line, 'C')
      description = spreadsheet.cell(line, 'D')
      shop_name = spreadsheet.cell(line, 'E')
      expenses_category_name = spreadsheet.cell(line, 'F')

      expense = user.expenses.new(name: name,
                                  price_value: price,
                                  description: description,
                                  shop_id: shop_id(shop_name),
                                  currency_id: currency_id(currency_name),
                                  expenses_category_id: expenses_category_id(expenses_category_name))
      save(expense)
    end
  end

  def persisted?
    false
  end

  private

  def save(expense)
    begin
      expense.save!
    rescue
      raise ImportError.new("Validation failed: #{expense.errors.full_messages.join(', ')}")
    end
  end

  def shop_id(name)
    begin
      Shop.find_by(name: name).id
    rescue
      raise ImportError.new("Shop with name '#{name}' was not found.")
    end
  end

  def currency_id(name)
    begin
      Currency.find_by(name: name).id
    rescue
      raise ImportError.new("Currency with name '#{name}' was not found.")
    end
  end

  def expenses_category_id(name)
    begin
      ExpensesCategory.find_by(name: name).id
    rescue
      raise ImportError.new("ExpensesCategory with name '#{name}' was not found.")
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.ods'
        Roo::OpenOffice.new(file.path)
      when '.csv'
        Roo::Csv.new(file.path)
      when '.xls'
        Roo::Excel.new(file.path)
      else
        raise ImportError.new("Unknown file type: #{file.original_filename}")
    end
  end
end
