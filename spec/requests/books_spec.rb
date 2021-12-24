require 'rails_helper'

RSpec.describe '/books', type: :request do
  # TODO, publish and unpublished a book.
  # TODO, add author to a book.
  let(:valid_attributes) { FactoryBot.attributes_for(:book) }
  let(:invalid_attributes) {
    FactoryBot.attributes_for(:book, quantity: -2, price: -1)
  }

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
      let(:new_attributes) { FactoryBot.attributes_for(:book) }

      it 'redirects to the book' do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(response).to redirect_to(book_url(book))
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
        patch unpublish_book_path(book)
        expect(book.reload.published?).to eq(false)
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
end