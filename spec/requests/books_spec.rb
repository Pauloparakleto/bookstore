require 'rails_helper'

RSpec.describe '/books', type: :request do
  let!(:admin) { create(:admin) }
  let(:valid_attributes) { FactoryBot.attributes_for(:book) }
  let(:invalid_attributes) {
    FactoryBot.attributes_for(:book, quantity: -2, price: -1)
  }

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      FactoryBot.create_list(:book, 3)
      get books_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      book = FactoryBot.create(:book)
      get book_url(book)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_book_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      book = Book.create! valid_attributes
      get edit_book_url(book)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Book' do
        expect {
          post books_url, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it 'redirects to the created book' do
        post books_url, params: { book: valid_attributes }
        expect(response).to redirect_to(book_url(Book.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Book' do
        expect {
          post books_url, params: { book: invalid_attributes }
        }.to change(Book, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post books_url, params: { book: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { FactoryBot.attributes_for(:book, quantity: 1) }
      let(:book){Book.create! valid_attributes}

      before do
        patch book_url(book), params: { book: new_attributes }
        book.reload
      end

      it 'redirects to the book' do
        expect(response).to redirect_to(book_url(book))
      end

      it 'creates audit book' do
        book = Book.create! valid_attributes
        expect {
          patch book_url(book), params: { book: new_attributes }
        }.to change(AuditBook, :count).by(1)
      end

      it 'blames current admin audit book' do
        expect(AuditBook.last.admin).to eq(admin)
      end

      it 'registers changes on book' do
        expect(AuditBook.last.book).to eq(book)
      end

      it 'registers changes on book title' do
        expect(AuditBook.last.title).to eq(new_attributes.fetch(:title))
      end

      it 'registers changes on book quantity' do
        expect(AuditBook.last.quantity).to eq(new_attributes.fetch(:quantity))
      end

      it 'registers changes on book price' do
        expect(AuditBook.last.price).to eq(new_attributes.fetch(:price).to_d)
      end
    end

    context 'with invalid parameters' do
      it "renders a non successful response (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: invalid_attributes }
        expect(response).to render_template(:edit)
      end

      it 'does not create audit book' do
        book = Book.create! valid_attributes
        expect {
          patch book_url(book), params: { book: invalid_attributes }
        }.to change(AuditBook, :count).by(0)
      end
    end
  end

  describe 'PATCH /publish' do
    context 'with valid parameters' do
      let(:new_attributes) { FactoryBot.attributes_for(:book) }

      it 'redirects to the book' do
        book = Book.create! valid_attributes
        book.unpublished!
        patch publish_book_path(book)
        expect(response).to redirect_to(book_url(book))
      end

      it 'book publish!' do
        book = Book.create! valid_attributes

        patch publish_book_path(book)

        expect(AuditBook.last.published).to eq('published')
      end

      it 'has book quantity nil!' do
        book = Book.create! valid_attributes

        patch publish_book_path(book)

        expect(AuditBook.last.quantity).to be_nil
      end

      it 'book published!' do
        book = Book.create! valid_attributes
        book.unpublished!
        patch publish_book_path(book)
        expect(book.reload.published?).to eq(true)
      end
    end

    context 'with invalid parameters' do
      it "renders a non successful response (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH /unpublish' do
    context 'with valid parameters' do
      let(:new_attributes) { FactoryBot.attributes_for(:book) }

      it 'redirects to the book' do
        book = Book.create! valid_attributes
        patch unpublish_book_path(book)
        expect(response).to redirect_to(book_url(book))
      end

      it 'book unpublish!' do
        book = Book.create! valid_attributes
        book.published!

        patch unpublish_book_path(book)

        expect(book.reload.published?).to eq(false)
      end

      it 'book unpublished!' do
        book = Book.create! valid_attributes
        book.published!
        book.reload

        patch unpublish_book_path(book)

        expect(AuditBook.last.published).to eq('unpublished')
      end

      it 'has book quantity nil!' do
        book = Book.create! valid_attributes

        book.published!

        patch unpublish_book_path(book)

        expect(AuditBook.last.quantity).to be_nil
      end
    end

    context 'with invalid parameters' do
      it "renders a non successful response (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET /books/:id/author/new' do
    it 'builds author list' do
      create_list(:author, 2)
      book = Book.create! valid_attributes
      get new_author_book_path(book)
      expect(response).to be_successful
    end
  end

  describe 'POST /books/:id/authors?author_id=:id' do
    it 'adds author to book' do
      author = create(:author)
      book = Book.create! valid_attributes
      post author_book_path(book), params: { author_id: author.id }
      expect(book.authors.count).to eq(1)
    end

    it 'redirects to books list' do
      book = create(:book)
      author = create(:author)
      post book_author_path(author), params: { book_id: book.id }
      expect(response).to redirect_to(books_path)
    end
  end
end
