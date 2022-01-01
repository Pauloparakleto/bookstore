module Audit
  class BookSheriff
    attr_reader :admin, :book
    attr_accessor :title, :quantity, :price

    def initialize(attributes, models)
      @attributes = attributes
      @admin = models.fetch(:admin)
      @book = models.fetch(:book)
    end

    def book_attributes_to_compare
      book.attributes.slice('title', 'quantity', 'price').symbolize_keys
    end

    def set_attributes_differences
      set_title_difference
      set_quantity_difference
      set_price_difference
    end

    def create
      set_attributes_differences
      AuditBook.create(admin_id: admin.id, book_id: book.id, title: title, quantity: quantity, price: price)
    end

    private

    def set_title_difference
      @title = @attributes.fetch(:title) unless book_attributes_to_compare.fetch(:title).eql?(@attributes.fetch(:title))
    end

    def set_price_difference
      @title = @attributes.fetch(:price) unless book_attributes_to_compare.fetch(:price).eql?(@attributes.fetch(:price))
    end

    def set_quantity_difference
      @quantity = @attributes.fetch(:quantity) unless book_attributes_to_compare.fetch(:quantity)
        .eql?(@attributes.fetch(:quantity))
    end
  end
end
