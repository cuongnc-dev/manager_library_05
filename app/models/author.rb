class Author < ApplicationRecord
  belongs_to :publisher

  has_many :books, dependent: :nullify
  has_many :follow_authors, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_email}
  validates :email, presence: true
  validates :phone, presence: true, length: {maximum: Settings.max_phone}
  validates :address, presence: true
  validates :publisher_id, presence: true
end
