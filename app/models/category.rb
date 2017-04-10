class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  has_many :books, through: :subcategories

  validates :name, presence: true, length: {maximum: Settings.max_name_email}

  scope :list_category_newest, -> {order created_at: :desc}
  scope :list_category_order_name, -> {order :name}
  scope :search_category_by_name, -> search {where "name like ?", "%#{search}%"}
end
