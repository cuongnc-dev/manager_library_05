class Book < ApplicationRecord
  belongs_to :category
  belongs_to :author
  belongs_to :publisher

  has_many :comments, dependent: :destroy
  has_many :follow_books, dependent: :destroy

  mount_uploader :image, PictureUploader

  validates :title, presence: true, length: {maximum: Settings.max_name_email}
  validates :image, presence: true
  validates :description, presence: true
  validates :current, presence: true
  validates :page_number, presence: true
  validates :author_id, presence: true
  validates :category_id, presence: true
  validates :publisher_id, presence: true

  delegate :name, to: :category, prefix: true
  delegate :name, to: :author, prefix: true
  delegate :name, to: :publisher, prefix: true

  scope :list_book_newest, -> {order "created_at desc"}
  scope :search_book_by_title, -> title {where "title like ?", "%#{title}%"}
end
