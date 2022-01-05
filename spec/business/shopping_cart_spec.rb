require 'rails_helper'

RSpec.describe ShoppingCart do
  describe 'shopping cart' do
    subject(:cart) { ShoppingCart.new(session_book_ids) }

    let!(:user) { create(:user) }
    let!(:books) { create_list(:book, 4) }
    let!(:session_book_ids){[books.first.id, books.second.id, books.second.id, books.third.id]}

    context 'when initialize' do
        it 'has book ids' do
            expect(cart.book_ids).to eq(session_book_ids)
        end

        it 'has unique ids' do
            expect(cart.book_unique_ids).to eq([books.first.id, books.second.id, books.third.id])
        end

        it 'has hash with book quantity pair' do
          cart.set_quantity
          expect(cart.quantity).to eq([1, 2, 1])
        end

        it 'has hash of book quantity pair' do
            cart.set_quantity
            cart.book_quantity_to_hash
            expect(cart.book_quantity).to eq({books.first.id=>1, books.second.id=>2, books.third.id=>1})
        end

        it 'gets 2 for second book quantity' do
            cart.set_quantity
            cart.book_quantity_to_hash
            expect(cart.get_quantity(books.second.id)).to eq(2)
        end
    end

    context 'when build items' do
        it 'has first item quantity 1' do
        end
    end
  end
end
