class Author < ApplicationRecord
  belongs_to :publisher

  has_many :books, dependent: :nullify
  has_many :follow_authors, dependent: :destroy

  mount_uploader :avatar, PictureUploader

  validates :name, presence: true, length: {maximum: Settings.max_name_email}
  validates :email, presence: true
  validates :phone, presence: true, length: {maximum: Settings.max_phone}
  validates :address, presence: true
  validates :publisher_id, presence: true

  delegate :name, to: :publisher, prefix: true
  delegate :name, to: :category, prefix: true

  scope :list_author_newest, -> {order "created_at desc"}
  scope :list_author_order_name, -> {order "name"}
  scope :search_author_by_name, -> name {where "name like ?", "%#{name}%"}
  scope :search_author_by_publisher, -> name do
    joins(:publisher).select("authors.*").where "publishers.name like ?", "%#{name}%"
  end
  scope :search_author_by_email, -> email {where "email like ?", "%#{name}%"}
end
