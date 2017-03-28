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
  validates :avatar, presence: true

  delegate :name, to: :publisher, prefix: true

  scope :list_newest_author, -> {order created_at: :desc}
  scope :search_author_by_name, -> name {where "name like ?", "%#{name}%"}
end
