class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :publish, :unpublish]
  before_action :build_book, only: [:create]

  def index
    @books = Book.published.map { |book| BooksPresenter.new(book) }
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
    @book.published!
    redirect_to book_path(@book), notice: 'Book published!'
  end

  def unpublish
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

  def books_params
    params.require(:book).permit(:title, :price, :quantity)
  end

  def build_book
    @book = Book.new(books_params)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
