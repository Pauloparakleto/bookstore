module BooksHelper
  def publish_or_unpublish_path(book)
    return publish_book_path(book) if book.unpublished?

    unpublish_book_path(book)
  end

  def display_link_name(book)
    return 'Publish' if book.unpublished?

    'Unpublish'
  end
end
