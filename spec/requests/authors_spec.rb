require 'rails_helper'

RSpec.describe '/authors', type: :request do
  let!(:admin) { create(:admin) }
  let(:valid_attributes) { FactoryBot.attributes_for(:author) }
  let(:invalid_attributes) {
    FactoryBot.attributes_for(:author, first_name: nil)
  }

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      FactoryBot.create_list(:author, 3)
      get authors_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      author = FactoryBot.create(:author)
      get author_url(author)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_author_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      author = Author.create! valid_attributes
      get edit_author_url(author)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Author' do
        expect {
          post authors_url, params: { author: valid_attributes }
        }.to change(Author, :count).by(1)
      end

      it 'redirects to the created author' do
        post authors_url, params: { author: valid_attributes }
        expect(response).to redirect_to(author_url(Author.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Book' do
        expect {
          post authors_url, params: { author: invalid_attributes }
        }.to change(Author, :count).by(0)
      end

      it 'renders new response' do
        post authors_url, params: { author: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { FactoryBot.attributes_for(:author) }
      let(:author) { Author.create! valid_attributes }

      before do
        patch author_url(author), params: { author: new_attributes }
        author.reload
      end

      it 'redirects to the author' do
        expect(response).to redirect_to(author_url(author))
      end

      it 'creates audit author' do
        author = Author.create! valid_attributes
        expect {
          patch author_url(author), params: { author: new_attributes }
        }.to change(AuditAuthor, :count).by(1)
      end

      it 'blames current admin audit author' do
        expect(AuditAuthor.last.admin).to eq(admin)
      end

      it 'registers changes on author' do
        expect(AuditAuthor.last.author).to eq(author)
      end

      it 'registers changes on author first name' do
        expect(AuditAuthor.last.first_name).to eq(new_attributes.fetch(:first_name))
      end

      it 'registers changes on author last name' do
        expect(AuditAuthor.last.last_name).to eq(new_attributes.fetch(:last_name))
      end
    end

    context 'with invalid parameters' do
      it "renders a non successful response (i.e. to display the 'edit' template)" do
        author = Author.create! valid_attributes
        patch author_url(author), params: { author: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET /authors/:id/books/new' do
    it 'builds books list' do
      create_list(:book, 2)
      author = Author.create! valid_attributes
      get new_book_author_path(author)
      expect(response).to be_successful
    end
  end

  describe 'POST /authors/:id/books?book_id=:id' do
    it 'adds book to author' do
      book = create(:book)
      author = Author.create! valid_attributes
      post book_author_path(author), params: { book_id: book.id }
      expect(author.books.count).to eq(1)
    end

    it 'redirects to books list' do
      book = create(:book)
      author = Author.create! valid_attributes
      post book_author_path(author), params: { book_id: book.id }
      expect(response).to redirect_to(books_path)
    end
  end
end
