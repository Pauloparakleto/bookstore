class ShoppingCart
    attr_reader :book_ids
    attr_accessor :book_unique_ids, :quantity, :book_quantity

    def initialize(array_of_ids)
        @book_ids = array_of_ids
        @book_unique_ids = book_ids.uniq
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