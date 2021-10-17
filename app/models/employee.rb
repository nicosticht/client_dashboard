class Employee < ApplicationRecord
  belongs_to :company
  has_many :consultants, dependent: :destroy
  has_many :clients, through: :consultants

  validates :identifier, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_validation :generate_token, on: :create

  scope :for_given_clients, -> (client_ids) { joins(:clients).where('clients.id' => client_ids) }

  def client_ids
    clients.pluck(:id)
  end

  def self.create_employees number_of_employees, company_id
    @employees = []
    company = Company.find company_id
    number_of_employees.times do
      employee = {first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, company_id: company.id, created_at: Time.now, updated_at: Time.now }
      # employee.company_id = company.id
      # employee.first_name = Faker::Name.first_name
      # employee.last_name = Faker::Name.last_name
    
      # employee.clients << client
      @employees << employee
    end
    # @saved_employees_ids = Employee.insert_all(@employees,returning: %w[id]) # returning parameters only works with Postgres Adapater at the moment.
    Employee.insert_all! @employees
  end

  private

  def generate_token
    begin
      self.identifier = SimpleTokenGenerator::Generator.call(slices: 3, size_of_slice: 2)
    end while self.class.exists?(identifier: identifier)
  end
end
