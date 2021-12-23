class Book < ApplicationRecord
  has_and_belongs_to_many :authors

  validates :title, :price, :quantity, presence: true

  scope :published, -> { where(published: true) }
end
