require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  let!(:book) { create(:book) }

  it 'has link to unpublished!' do
    link_path = helper.publish_or_unpublish_path(book)
    expect(link_path).to eq(unpublish_book_path(book))
  end

  it 'has link to published!' do
    book.unpublished!
    link_path = helper.publish_or_unpublish_path(book.reload)
    expect(link_path).to eq(publish_book_path(book))
  end
end
