class BooksController < ApplicationController
  def index
    @books = Book.published.map { |book| BooksPresenter.new(book) }
  end
end
