class Publisher < ApplicationRecord
  has_many :authors, dependent: :nullify

  mount_uploader :image, PictureUploader

  validates :name, presence: true, length: {maximum: Settings.max_name_email}
  validates :email, presence: true
  validates :phone, presence: true, length: {maximum: Settings.max_phone}
  validates :address, presence: true
  validates :image, presence: true

  scope :list_newest_publisher, -> {order created_at: :desc}
  scope :search_publisher_by_namee, -> name {where "name like ?", "%#{name}%"}
end
