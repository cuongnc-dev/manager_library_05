class Publisher < ApplicationRecord
  has_many :authors, dependent: :destroy
end
