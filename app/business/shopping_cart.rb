class ShoppingCart
  attr_reader :book_ids
  attr_accessor :book_unique_ids, :quantity, :book_quantity, :order

  def initialize(array_of_ids)
    @book_ids = array_of_ids
    @book_unique_ids = book_ids.uniq
    @order = Order.new
  end

  def build_order
    set_quantity
    book_quantity_to_hash
    add_items_to_order
    order
  end

  private

  def add_items_to_order
    book_quantity_to_hash.each do |id|
      book = Book.find(id)
      quantity = get_quantity(id)
      order.items.build(name: book.title, price: book.price, quantity: quantity, book_id: id)
    end
  end

  def set_quantity
    @quantity = []
    book_unique_ids.each do |id|
      quantity << book_ids.count(id)
    end
  end

  def book_quantity_to_hash
    @book_quantity = {}
    book_unique_ids.each_with_index do |book_id, index|
      book_quantity[book_id] = quantity[index]
    end
  end

  def get_quantity(book_id)
    book_quantity.fetch(book_id, nil)
  end
end
