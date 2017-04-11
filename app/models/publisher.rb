class Publisher < ApplicationRecord
  has_many :authors, dependent: :nullify

  mount_uploader :image, PictureUploader

  validates :name, presence: true, length: {maximum: Settings.max_name_email}
  validates :email, presence: true
  validates :phone, presence: true, length: {maximum: Settings.max_phone}
  validates :address, presence: true

  scope :list_publisher_newest, -> {order "created_at desc"}
  scope :list_publisher_order_name, -> {order "name"}
  scope :search_publisher_by_name, -> name {where "name like ?", "%#{name}%"}
  scope :search_publisher_by_email, -> email {where "email like ?", "%#{email}%"}
end
