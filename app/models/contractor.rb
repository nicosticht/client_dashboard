class Contractor < ApplicationRecord
  belongs_to :partner_company
  has_many :consultants
  has_many :clients, through: :consultants

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :for_given_clients, -> (client_ids) { joins(:clients).where('clients.id' => client_ids) }
end