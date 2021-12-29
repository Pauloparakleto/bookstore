require 'rails_helper'

RSpec.describe '/users/orders', type: :request do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GETS cart' do
    it 'redirects to users books' do
      get cart_users_orders_path
      expect(response).to be_successful
    end
  end

  describe 'POSTs users/orders/add_book' do
    let!(:book) { create_list(:book, 2) }

    before do
      post add_book_users_orders_path, params: { book: { id: book.first.id } }
    end

    it { is_expected.to redirect_to(users_books_path) }
  end

  describe 'POSTs users/orders/remove_book' do
    let!(:book) { create_list(:book, 2) }

    before do
      post remove_book_users_orders_path, params: { book: { id: book.first.id } }
    end

    it { is_expected.to redirect_to(cart_users_orders_path) }
  end

  describe 'POSTs users/orders/' do
    let!(:book) { create_list(:book, 2) }

    before do
      post users_orders_path,
           params: { order: { items_attributes: [attributes_for(:item, name: book.first.title,
                                                                       book_id: book.first.id)] } }
    end

    it { is_expected.to redirect_to(users_order_path(Order.last)) }

    it 'belongs to user' do
      expect(Order.last.user).to eq(user)
    end

    it 'has item' do
      expect(Order.last.items.first.name).to eq(book.first.title)
    end
  end

  describe 'GETs users/orders/show' do
    let!(:book) { create_list(:book, 2) }
    let!(:item) { create(:item, book: book.first) }
    let!(:order) { create(:order, items: [item], user: user) }

    before do
      get users_order_path(order)
    end

    it 'render template show' do
      expect(response).to render_template('show')
    end
  end
end
