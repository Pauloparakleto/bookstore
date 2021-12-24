require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:title) { Faker::Book.title }
  let!(:price) { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  let!(:book) {
    described_class.create(title: title, price: price, published: true,
                           quantity: 27)
  }

  describe 'validations' do
    subject { book }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe 'collection' do
    before do
      create_list(:book, 3, published: false)
    end

    it 'counts 1 published' do
      expect(described_class.published.count).to eq(1)
    end
  end

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

    context 'with author' do
      before do
        book.authors.build([FactoryBot.attributes_for(:author),
                            FactoryBot.attributes_for(:author)])
        book.save
      end

      it 'counts 1 authors' do
        expect(book.authors.count).to eq(2)
      end

      it 'has author first name' do
        expect(book.authors.first.first_name).to be_truthy
      end

      it 'has author last name' do
        expect(book.authors.first.last_name).to be_truthy
      end
    end
  end

  describe 'new attributes' do
    context 'when update valid' do
      before do
        new_attributes = FactoryBot.attributes_for(:book, published: false)
        book.update(new_attributes)
      end

      it 'has title' do
        expect(book.reload.title).not_to eq(title)
      end

      it 'has price' do
        expect(book.reload.price).not_to eq(price)
      end

      it 'has published' do
        expect(book.reload.published).not_to eq(true)
      end

      it 'has published?' do
        expect(book.reload.published?).not_to eq(true)
      end

      it 'has quantity' do
        expect(book.reload.quantity).not_to eq(27)
      end
    end

    context 'with author' do
      before do
        book.authors.build([{ first_name: Faker::Book.author.first,
                              last_name: Faker::Book.author.last },
                            { first_name: Faker::Book.author.first,
                              last_name: Faker::Book.author.last }])
        book.save
      end

      it 'changes author first name' do
        author_first_name = book.authors.first.first_name
        author_id = book.authors.first.id
        book.authors.find(author_id).update(first_name: Faker::Book.author.first)

        expect(book.authors.reload.first.first_name).not_to eq(author_first_name)
      end

      it 'changes author last name' do
        author_last_name = book.authors.first.first_name
        author_id = book.authors.first.id
        book.authors.find(author_id).update(last_name: Faker::Book.author.first)

        expect(book.authors.reload.first.last_name).not_to eq(author_last_name)
      end
    end
  end
end
