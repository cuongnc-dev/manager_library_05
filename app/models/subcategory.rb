class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :books, dependent: :nullify

  validates :name, presence: true, length: {maximum: Settings.max_name_email}
  validates :category_id, presence: true

  delegate :name, to: :category, prefix: true

  scope :list_subcategory_newest, -> {order created_at: :desc}
  scope :list_subcategory_order_name, -> {order :name}
  scope :list_subcategory_by_category, -> id do
    joins(:category).select("subcategories.*").where "category_id = ?", "#{id}"
  end
  scope :list_subcategory_by_category_name, -> name do
    joins(:category).select("subcategories.*").
      where "categories.name like ?", "%#{name}%"
  end
  scope :search_subcategory_by_name, -> name {where "name like ?", "%#{name}%"}
end
