class ShoppingCart
    attr_reader :book_ids
    attr_accessor :book_unique_ids, :quantity

    def initialize(array_of_ids)
        @book_ids = array_of_ids
        @book_unique_ids = book_ids.uniq
    end

    def set_book_unique_ids
       
    end

    def set_book_quantity
        @quantity = []
        book_unique_ids.each do |id|
            quantity << book_ids.count(id)
        end
    end
end