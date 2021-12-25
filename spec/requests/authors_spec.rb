require 'rails_helper'

RSpec.describe '/authors', type: :request do
  let(:valid_attributes) { FactoryBot.attributes_for(:author) }
  let(:invalid_attributes) {
    FactoryBot.attributes_for(:author, first_name: nil)
  }

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

      it 'redirects to the author' do
        author = Author.create! valid_attributes
        patch author_url(author), params: { author: new_attributes }
        author.reload
        expect(response).to redirect_to(author_url(author))
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
end
