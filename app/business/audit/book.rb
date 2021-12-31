module Audit
  class Book
    def initialize(attributes, models)
      @attributes = attributes
      @admin = models.fetch(:admin)
      @book = models.fetch(:book)
    end
  end
end
