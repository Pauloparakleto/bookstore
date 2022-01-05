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
      describe 'items quantity' do
        it 'has first item quantity 1' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.first.quantity).to eq(1)
        end
        
        it 'has second item quantity 2' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.second.quantity).to eq(2)
        end
        
        it 'has third item quantity 1' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.third.quantity).to eq(1)
        end
      end
      
      describe 'items price' do
        it 'is equal book first price' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.first.price).to eq(books.first.price)
        end
        
        it 'is equal book second price' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.second.price).to eq(books.second.price)
        end
        
        it 'is equal book third price' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.third.price).to eq(books.third.price)
        end
      end
      
      describe 'items name' do
        it 'is equal book first title' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.first.name).to eq(books.first.title)
        end
        
        it 'is equal book second title' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.second.name).to eq(books.second.title)
        end
        
        it 'is equal book third title' do
          cart.set_quantity
          cart.book_quantity_to_hash
          cart.build_order
          expect(cart.order.items.third.name).to eq(books.third.title)
        end
      end
    end
  end
end
