class Book < ApplicationRecord
  belongs_to :category
  belongs_to :author
  belongs_to :publisher
  
  has_many :comments, dependent: :destroy
  has_many :follow_books, dependent: :destroy
end
