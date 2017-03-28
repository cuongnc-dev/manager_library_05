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

  scope :list_newest_book, -> {order created_at: :desc}
  scope :list_newest_limit, -> limit {order(created_at: :desc).limit(limit)}
  scope :search_book_by_title, -> search {where "title like ?", "%#{search}%"}
  scope :search_book_by_author, -> search do
    joins(:author).where "authors.name like ?", "%#{search}%"
  end
  scope :search_book_by_category, -> search do
    joins(:category).where "categories.name like ?", "%#{search}%"
  end
  scope :search_book_by_publisher, -> search do
    joins(:publisher).where "publishers.name like ?", "%#{search}%"
  end
end
