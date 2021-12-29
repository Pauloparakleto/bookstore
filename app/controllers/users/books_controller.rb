module Users
  class BooksController < Users::UsersController
    skip_before_action :authenticate_user!
    def index
      @books = Book.published.map { |book| BooksPresenter.new(book) }
    end

    def show
      @book = Book.find(params[:id])
    end
  end
end
