require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:title) { Faker::Book.title }
  let!(:price) { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  let!(:book) {
    described_class.create(title: title, price: price, published: true,
                           quantity: 27)
  }

  describe 'attributes' do
    context 'when create' do
      it 'has title' do
        expect(book.title).to eq(title)
      end

      it 'has price' do
        expect(book.price).to eq(price)
      end

      it 'has published' do
        expect(book.published).to eq(true)
      end

      it 'has published?' do
        expect(book.published?).to eq(true)
      end

      it 'has quantity' do
        expect(book.quantity).to eq(27)
      end
    end
  end

  describe 'new attributes' do
    context 'when update valid' do
      before do
        new_attributes = { title: Faker::Book.title, price: Faker::Number.number,
                           published: false, quantity: Faker::Number.number.to_i }
        book.update(new_attributes)
      end

      it 'has title' do
        expect(book.title).not_to eq(title)
      end

      it 'has price' do
        expect(book.price).not_to eq(price)
      end

      it 'has published' do
        expect(book.published).not_to eq(true)
      end

      it 'has published?' do
        expect(book.published?).not_to eq(true)
      end

      it 'has quantity' do
        expect(book.quantity).not_to eq(27)
      end
    end
  end
end
