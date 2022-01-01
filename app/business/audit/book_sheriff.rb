module Audit
  class BookSheriff
    attr_reader :admin, :book
    attr_accessor :title, :quantity, :price, :published

    def initialize(attributes, models)
      @attributes = attributes
      @admin = models.fetch(:admin)
      @book = models.fetch(:book)
      set_attributes_differences
    end

    def book_attributes_to_compare
      book.attributes.slice('title', 'quantity', 'price', 'published').symbolize_keys
    end

    def set_attributes_differences
      set_title_difference
      set_quantity_difference
      set_price_difference
      set_published_difference
    end

    def create
      set_attributes_differences
      AuditBook.create(admin_id: admin.id, book_id: book.id, title: title, quantity: quantity, price: price,
                       published: published)
    end

    private

    def set_title_difference
      @title = @attributes.fetch(:title) unless book_attributes_to_compare.fetch(:title).eql?(@attributes.fetch(:title))
    end

    def set_price_difference
      @price = @attributes.fetch(:price) unless book_attributes_to_compare.fetch(:price).eql?(@attributes.fetch(:price))
    end

    def set_published_difference
      @published = @attributes.fetch(:published, nil) unless book_attributes_to_compare.
        fetch(:published,
              nil).eql?(@attributes.fetch(
      :published, nil
    ))
    end

    def set_quantity_difference
      @quantity = @attributes.fetch(:quantity) unless book_attributes_to_compare.fetch(:quantity)
        .eql?(@attributes.fetch(:quantity))
    end
  end
end
