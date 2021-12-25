class AuthorsController < ApplicationController
  before_action :build_author, only: [:create]
  before_action :set_author, only: [:edit, :update, :show]

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
end
