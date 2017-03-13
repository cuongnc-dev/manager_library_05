class Publisher < ApplicationRecord
  has_many :authors, dependent: :nullify

  validates :name, presence: true, length: {maximum: Settings.max_name_email}
  validates :email, presence: true
  validates :phone, presence: true, length: {maximum: Settings.max_phone}
  validates :address, presence: true
end
