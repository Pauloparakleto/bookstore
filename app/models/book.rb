class Book < ApplicationRecord
  has_and_belongs_to_many :authors

  validates :title, :price, :quantity, presence: true
  validates :price, :quantity, numericality: { greater_than_or_equal_to: 0 }

  enum published: { published: true, unpublished: false }
end
