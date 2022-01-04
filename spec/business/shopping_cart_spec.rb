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
          cart.set_book_quantity
          expect(cart.quantity).to eq([1, 2, 1])
        end
    end
  end
end
