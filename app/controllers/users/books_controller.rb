module Users
  class BooksController < ApplicationController
    def index
      @books = Book.published.map { |book| BooksPresenter.new(book) }
    end

    def show
      @book = Book.find(params[:id])
    end
  end
end
