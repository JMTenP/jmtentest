class Payment < ApplicationRecord

  belongs_to :account, optional: true

  has_many :notes, as: :resource

  validates_uniqueness_of :uuid
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
