class EmployeesImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_employees
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      employee = Employee.find_by_id(row["ID"]) || Employee.new(first_name: row["First Name"],last_name: row["Last Name"], company_id: Company.find_by(name: row["Company Name"]).id)
      #employee.attributes = row.to_hash
      employee
    end
  end

  def imported_employees
    @imported_employees ||= load_imported_employees
  end

  def save
    if imported_employees.map(&:valid?).all?
      imported_employees.each(&:save!)
      true
    else
      imported_employees.each_with_index do |employee, index|
        employee.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 6}: #{msg}"
        end
      end
      false
    end
  end

end