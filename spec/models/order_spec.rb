require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:item) { create_list(:item, 2, name: book.title, book: book) }
  let!(:order) { create(:order, items: item, user: user) }

  context 'when create' do
    it 'belongs to user' do
      expect(order.user).to eq(user)
    end

    it 'has 1 book now available' do
      expect(book.reload.quantity).to eq(2)
    end

    it 'counts order' do
      expect(described_class.count).to eq(1)
    end

    it 'has two items' do
      expect(order.items.count).to eq(2)
    end

    it 'has first item with name' do
      expect(order.items.first.name).to eq(book.title)
    end

    it 'has first item with price' do
      expect(order.items.first.price).to eq(1.5)
    end

    it 'has first item with quantity' do
      expect(order.items.first.quantity).to eq(2)
    end

    it 'has second item with name' do
      expect(order.items.second.name).to eq(book.title)
    end

    it 'has second item with price' do
      expect(order.items.second.price).to eq(1.5)
    end

    it 'has second item with quantity' do
      expect(order.items.second.quantity).to eq(2)
    end

    it 'sums 6.0' do
      expect(order.total_price).to eq(6.0)
    end

    it 'has subtotal' do
      expect(order.items.first.subtotal).to eq(3.0)
    end
  end

  context 'when create invalid' do
    it 'has item quantity greater than book quantity' do
      message = ['Items quantity This quantity is greater than the books quantity available', 'User must exist']
      order = described_class.new(items_attributes: [{ name: item.first.book.title, price: 1.0,
                                                       quantity: 3, book_id: book.id }])
      order.save
      expect(order.errors.full_messages).to eq(message)
    end
  end

  context 'when update' do
    it 'does not change the first item quantity' do
      order.update(items_attributes: [{ id: order.items.first.id, quantity: 3 }])
      expect(order.items.first.quantity).to eq(2)
    end

    it 'does not change the second item quantity' do
      order.update(items_attributes: [{ id: order.items.second.id, quantity: 4 }])
      expect(order.items.second.quantity).to eq(2)
    end

    it 'sums 6.0 including one more book to item' do
      order.update(items_attributes: [{ id: order.items.first.id, quantity: 3 }])
      expect(order.total).to eq(6.0)
    end

    it 'sums 6.0 including on more drink' do
      order.update(items_attributes: [{ id: order.items.second.id, quantity: 4 }])
      expect(order.total).to eq(6.0)
    end
  end
end
