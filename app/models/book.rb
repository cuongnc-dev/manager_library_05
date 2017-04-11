class Book < ApplicationRecord
  belongs_to :subcategory
  belongs_to :author
  belongs_to :publisher
  has_one :category, through: :subcategory

  has_many :comments, dependent: :destroy
  has_many :follow_books, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :image, PictureUploader

  validates :title, presence: true, length: {maximum: Settings.max_name_email}
  validates :image, presence: true
  validates :description, presence: true
  validates :current, presence: true
  validates :page_number, presence: true
  validates :author_id, presence: true
  validates :subcategory_id, presence: true
  validates :publisher_id, presence: true

  delegate :name, to: :subcategory, prefix: true, allow_nil: true
  delegate :name, to: :author, prefix: true
  delegate :name, to: :publisher, prefix: true
  delegate :name, to: :category, prefix: true

  def send_notification_email(users, book)
    users.each do |user|
      UserMailer.book_notification(user, book).deliver
    end
  end

  scope :list_book_newest, -> {order created_at: :desc}
  scope :list_book_newest_limit, -> limit {order(created_at: :desc).limit(limit)}
  scope :list_book_high_rating, -> limit do
    joins(:rates).select("books.*, avg(rates.rates) as avg_rating,
      count(rates.id) as number_of_rates")
     .group("books.id").order("avg_rating DESC, number_of_rates DESC").limit(limit)
  end
  scope :list_book_by_author, -> id do
    joins(:author).select("books.*").where "authors.id = ?", "#{id}"
  end
  scope :search_book_by_title, -> search {where "title like ?", "%#{search}%"}
  scope :search_book_by_author, -> search do
    joins(:author).where "authors.name like ?", "%#{search}%"
  end
  scope :search_book_by_category, -> search do
    joins(:category).select("books.*").where "categories.name like ?", "%#{search}%"
  end
  scope :search_book_by_subcategory, -> search do
    joins(:subcategory).where "subcategories.name like ?", "%#{search}%"
  end
  scope :search_book_by_publisher, -> search do
    joins(:publisher).where "publishers.name like ?", "%#{search}%"
  end
end
