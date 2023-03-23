class Guest < ApplicationRecord
  has_many :reservations

  validates :phone, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
