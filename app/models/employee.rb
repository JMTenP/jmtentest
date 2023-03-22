class Employee < ApplicationRecord
 
  attribute :status, :string, default: 'inactive'
  attribute :title, :string, default: 'New employee tittle'

  belongs_to :user
  belongs_to :account

  has_many :notes, as: :resource
  #has many :payments
end
