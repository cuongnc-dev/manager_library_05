class Category < ApplicationRecord
  has_many :books, dependent: :nullify

  validates :name, presence: true, length: {maximum: Settings.max_name_email}

  scope :list_newest_category, -> {order created_at: :desc}
  scope :search_category_by_name, -> name {where "name like ?", "%#{name}%"}
end
