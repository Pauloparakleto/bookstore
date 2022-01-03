class AuthorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :build_author, only: :create
  before_action :set_author, only: [:edit, :update, :show]
  before_action :call_author_sheriff, only: [:update]
  after_action :create_author_sheriff, only: [:update]

  def index
    @authors = Author.all.map { |author| AuthorsPresenter.new(author) }
  end

  def show; end

  def new
    @author = Author.new
  end

  def create
    if @author.save
      redirect_to author_path(@author), notice: 'Author Created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @author.update(authors_params)
      redirect_to author_path(@author), notice: 'Author updated!'
    else
      render :edit
    end
  end

  def new_book
    @author = Author.find(params[:id])
    @books = Book.published.map { |book| BooksPresenter.new(book) }
  end

  def book
    @author = Author.find(params[:id])
    @book = Book.find(params[:book_id])
    @author.books << @book
    redirect_to books_path, notice: 'The author was included!'
  end

  private

  def authors_params
    params.require(:author).permit(:first_name, :last_name)
  end

  def build_author
    @author = Author.new(authors_params)
  end

  def set_author
    @author = Author.find(params[:id])
    @books = @author.books.map { |book| BooksPresenter.new(book) }
    @author
  end

  def call_author_sheriff
    @author_sheriff = Audit::AuthorSheriff.new(authors_params, { admin: current_admin, author: @author })
  end

  def create_author_sheriff
    return unless @author.valid?

    @author_sheriff.create
  end
end
