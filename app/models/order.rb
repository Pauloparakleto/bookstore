class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items

  def update(attributes)
    nil
  end

  def total
    items.sum(&:subtotal)
  end
end
