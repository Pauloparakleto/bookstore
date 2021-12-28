require 'rails_helper'

RSpec.describe 'users/books/', type: :request do
  describe 'GETs Index' do
    before do
      FactoryBot.create_list(:book, 2)
      get users_books_path
    end

    it { is_expected.to render_template('index') }
  end

  describe 'GETs Show' do
    before do
      book = FactoryBot.create(:book)
      get users_book_path(book)
    end

    it { is_expected.to render_template('show') }
  end
end
