class EmployeeImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if invalid_file_format
      errors.add(:base, 'invalid file format')
      return false
    end

    if invalid_headers.any?
      errors.add(:base, "invalid headers #{invalid_headers.join(', ')}")
      return false
    end

    if imported_products.map(&:valid?).all? 
      imported_products.each(&:save!)
      true
    else
      imported_products.each_with_index do |employee, index|
        employee.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_products
    @imported_products ||= load_imported_products(file)
  end

  def invalid_headers
    @invalid_headers ||= find_invalid_headers(file)
  end

  def invalid_file_format
    ['.xls', '.xlsx'].exclude?(File.extname(file.original_filename))
  end

  def load_imported_products(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      employee = Employee.find_by_id(row["id"]) || Employee.new(row.to_hash)
      employee.attributes = row.to_hash
      employee
    end
  end

  def find_invalid_headers(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)

    invalid_headers = []
    header.each do |column|
      if !Employee.column_names.include?(column)
        invalid_headers << column
      end
    end
    invalid_headers
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.xls' then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    end
  end
end