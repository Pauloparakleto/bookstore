class Item < ApplicationRecord
  belongs_to :book

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validate :book_quantity_available

  after_save :subtract_book_quantity

  def subtract_book_quantity
    book.quantity = book.quantity - quantity
    book.save
  end

  def book_quantity_available
    return unless quantity > book.quantity

    errors.add(:quantity,
               message: 'This quantity is greater than the books quantity available')
  end

  def subtotal
    price * quantity
  end
end
