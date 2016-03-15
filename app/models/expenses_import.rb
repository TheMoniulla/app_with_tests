class ExpensesImport < Struct.new(:file)
  require 'roo'

  def import_for(user)
    spreadsheet = open_spreadsheet(file)

    spreadsheet.default_sheet = spreadsheet.sheets.first
    (2..spreadsheet.last_row).each do |line|
      name = spreadsheet.cell(line, 'A')
      price = spreadsheet.cell(line, 'B')
      currency = spreadsheet.cell(line, 'C')
      description = spreadsheet.cell(line, 'D')
      shop = spreadsheet.cell(line, 'E')
      category = spreadsheet.cell(line, 'F')

      user.expenses.create!(name: name,
                            price_value: price,
                            description: description,
                            shop_id: Shop.find_by(name: shop).id,
                            currency_id: Currency.find_by(name: currency).id,
                            expenses_category_id: ExpensesCategory.find_by(name: category).id)
    end
  end

  def persisted?
    false
  end

  private

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.ods'
        Roo::OpenOffice.new(file.path)
      when '.csv'
        Roo::Csv.new(file.path)
      when '.xls'
        Roo::Excel.new(file.path)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end
end
