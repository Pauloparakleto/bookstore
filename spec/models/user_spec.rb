require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  let!(:book) { create(:book) }
  let!(:order) { Order.new }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  context 'when create' do
    it 'has email' do
      expect(user.email).to be_truthy
    end
  end

  describe 'association to order' do
    before do
      order.items.build({ name: book.title, price: book.price, quantity: 2, book_id: book.id })
      user.orders << order
    end

    it 'has order' do
      expect(user.orders.first).to be_truthy
    end

    it 'counts 1 order' do
      expect(user.orders.count).to eq(1)
    end

    it 'counts 1 item' do
      expect(user.orders.first.items.count).to eq(1)
    end

    it 'has order item' do
      expect(user.orders.first.items.first.name).to eq(book.title)
    end
  end
end
