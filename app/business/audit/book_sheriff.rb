module Audit
  class BookSheriff
    attr_reader :admin, :book

    def initialize(attributes, models)
      @attributes = attributes
      @admin = models.fetch(:admin)
      @book = models.fetch(:book)
    end

    def check_difference
      book_from_database = Book.find(book.id)
      book_attributes_from_database = book_from_database.attributes.slice('title', 'quantity', 'price').symbolize_keys
      @attributes.delete_if { |_k, v| book_attributes_from_database.value?(v) }
    end
  end
end
