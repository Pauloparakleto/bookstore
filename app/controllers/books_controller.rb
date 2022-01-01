class BooksController < ApplicationController
  before_action :authenticate_admin!
  before_action :present_book, only: [:show, :update, :publish, :unpublish]
  before_action :set_book, only: [:edit]
  before_action :build_book, only: [:create]
  before_action :call_book_sheriff, only: [:update]
  after_action :create_audit_book, only: [:update, :publish, :unpublish]

  def index
    @books = Book.published.map { |book| BooksPresenter.new(book) }
    @unpublished_books = Book.unpublished.map { |unpublished_book| BooksPresenter.new(unpublished_book) }
  end

  def unpublished
    @books = Book.unpublished.map { |book| BooksPresenter.new(book) }
    render :index
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    if @book.save
      redirect_to book_path(@book), notice: 'Book was created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update(books_params)

      redirect_to book_path(@book), notice: 'The Book was updated!'
    else
      render :edit
    end
  end

  def publish
    @book_sheriff = Audit::BookSheriff.new(published_params_to_book_sheriff,
                                           { admin: current_admin, book: @book })
    @book.published!
    redirect_to book_path(@book), notice: 'Book published!'
  end

  def unpublish
    @book_sheriff = Audit::BookSheriff.new(unpublished_params_to_book_sheriff,
                                           { admin: current_admin, book: @book })
    @book.unpublished!
    redirect_to book_path(@book), notice: 'Book unpublished!'
  end

  def new_author
    @book = Book.find(params[:id])
    @authors = Author.all
  end

  def author
    @book = Book.find(params[:id])
    @author = Author.find(params[:author_id])
    @book.authors << @author
    redirect_to books_path, notice: 'The author was included!'
  end

  private

  def published_params_to_book_sheriff
    { title: nil, quantity: nil, price: nil, published: true }
  end

  def unpublished_params_to_book_sheriff
    { title: nil, quantity: nil, price: nil, published: 'unpublished' }
  end

  def call_book_sheriff
    @book_sheriff = Audit::BookSheriff.new(books_params, { admin: current_admin, book: @book })
  end

  def create_audit_book
    return unless @book.valid?

    @book_sheriff.create
  end

  def books_params
    params.require(:book).permit(:title, :price, :quantity)
  end

  def build_book
    @book = Book.new(books_params)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def present_book
    book = Book.find(params[:id])
    @book = BooksPresenter.new(book)
  end
end
