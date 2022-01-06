require 'rails_helper'

RSpec.describe ShoppingCart do
  describe 'shopping cart' do
    subject(:cart) { described_class.new(session_book_ids) }

    let!(:books) { create_list(:book, 4) }
    let!(:session_book_ids) { [books.first.id, books.second.id, books.second.id, books.third.id] }

    context 'when initialize' do
      it 'has book ids' do
        expect(cart.book_ids).to eq(session_book_ids)
      end

      it 'has unique ids' do
        expect(cart.book_unique_ids).to eq([books.first.id, books.second.id, books.third.id])
      end

      it 'has an instance of order' do
        expect(cart.order).to be_a(Order)
      end
    end

    context 'when build items' do
      it 'has first item quantity 1' do
        cart.build_order
        expect(cart.order.items.first.quantity).to eq(1)
      end

      it 'has second item quantity 2' do
        cart.build_order
        expect(cart.order.items.second.quantity).to eq(2)
      end

      it 'has third item quantity 1' do
        cart.build_order
        expect(cart.order.items.third.quantity).to eq(1)
      end

      it 'is equal book first price' do
        cart.build_order
        expect(cart.order.items.first.price.to_d).to eq(books.first.price.to_d)
      end

      it 'is equal book second price' do
        cart.build_order
        expect(cart.order.items.second.price.to_d).to eq(books.second.price.to_d)
      end

      it 'is equal book third price' do
        cart.build_order
        expect(cart.order.items.third.price.to_d).to eq(books.third.price.to_d)
      end

      it 'is equal book first title' do
        cart.build_order
        expect(cart.order.items.first.name).to eq(books.first.title)
      end

      it 'is equal book second title' do
        cart.build_order
        expect(cart.order.items.second.name).to eq(books.second.title)
      end

      it 'is equal book third title' do
        cart.build_order
        expect(cart.order.items.third.name).to eq(books.third.title)
      end
    end
  end
end
