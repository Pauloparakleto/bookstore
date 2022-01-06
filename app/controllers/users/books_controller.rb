module Users
  class BooksController < Users::UsersController
    before_action :authenticate_user!, if: :check_admin?
    def index
      @books = Book.published.order('title ASC').map { |book| BooksPresenter.new(book) }
    end

    def show
      book = Book.find(params[:id])
      @book = BooksPresenter.new(book)
    end

    private

    def check_admin?
      current_admin.present?
    end
  end
end
