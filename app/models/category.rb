class Category < ApplicationRecord
  has_many :books, dependent: :nullify

  validates :name, presence: true, length: {maximum: Settings.max_name}
end
