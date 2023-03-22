class Account < ApplicationRecord
 
  belongs_to :user

  # Recoverable relations
 
  has_many :payments, dependent: :destroy
  
  # Unrecoverable relations
  
  # Paranoid

  
  # Account info

  def email
    user.email
  end

  def name
    verification&.name
  end

  def surname
    verification&.surname
  end

  def gender
    verification&.gender
  end

  def birthdate
    verification&.birthdate
  end

  def country
    verification&.country
  end

  def age
    (Time.now.to_s(:number).to_i - birthdate.to_time.to_s(:number).to_i)/10e9.to_i
  end

  def iban
    payment_methods.where.not(iban: nil).first&.iban
  end
