class Author < ApplicationRecord
  belongs_to :publisher
  
  has_many :books, dependent: :destroy
  has_many :follow_authors, dependent: :destroy
end
