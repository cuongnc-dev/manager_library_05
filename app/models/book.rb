class Book < ApplicationRecord
  belongs_to :category
  belongs_to :author
  belongs_to :publisher

  has_many :comments, dependent: :destroy
  has_many :follow_books, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.max_name_email}
  validates :image, presence: true
  validates :description, presence: true
  validates :current, presence: true
  validates :author_id, presence: true
  validates :category_id, presence: true
  validates :publisher_id, presence: true
end
