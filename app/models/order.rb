class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :items

  before_save :set_total_price

  def update(_attributes)
    nil
  end

  def set_total_price
    self.total_price = total
  end

  def total
    items.sum(&:subtotal)
  end
end
