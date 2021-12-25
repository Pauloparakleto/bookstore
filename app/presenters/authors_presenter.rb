class AuthorsPresenter < SimpleDelegator
  def books
    super.map { |book| book.title.to_s }.join(', ')
  end
end
