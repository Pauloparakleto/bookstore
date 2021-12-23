require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:title) { Faker::Book.title }
  let!(:price) { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  let!(:book) { described_class.create(title: title, price: price, published: true) }

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
    end
  end
end
