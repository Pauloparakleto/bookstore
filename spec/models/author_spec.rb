require 'rails_helper'

RSpec.describe Author, type: :model do
  let!(:first_name) { Faker::Name.first_name }
  let!(:last_name) { Faker::Name.last_name }
  let!(:author) {
    create(:author, first_name: first_name,
                    last_name: last_name)
  }

  describe 'validations' do
    subject { author }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'collection' do
    before do
      create_list(:author, 3)
    end

    it 'counts 1 published' do
      expect(described_class.count).to eq(3)
    end
  end

  describe 'attributes' do
    context 'when create' do
      it 'has first name' do
        expect(author.first_name).to eq(first_name)
      end

      it 'has last name' do
        expect(author.last_name).to eq(last_name)
      end
    end

    context 'with book' do
      before do
        author.books.build([FactoryBot.attributes_for(:book),
                            FactoryBot.attributes_for(:book)])
        author.save
      end

      it 'counts 2 books' do
        expect(author.books.count).to eq(2)
      end

      it 'has author first name' do
        expect(author.books.first.title).to be_truthy
      end
    end
  end

  describe 'new attributes' do
    context 'when update valid' do
      before do
        new_attributes = FactoryBot.attributes_for(:author)
        author.update(new_attributes)
      end

      it 'has first name' do
        expect(author.reload.first_name).not_to eq(first_name)
      end

      it 'has price' do
        expect(author.reload.last_name).not_to eq(last_name)
      end
    end

    context 'with books' do
      before do
        author.books.build([attributes_for(:book), attributes_for(:book)])
        author.save
      end

      it 'changes book title' do
        book_title = author.books.first.title
        book_id = author.books.first.id
        author.books.find(book_id).update(title: Faker::Book.title)

        expect(author.books.reload.first.title).not_to eq(book_title)
      end

      it 'changes book price' do
        book_price = author.books.first.price
        book_id = author.books.first.id
        author.books.find(book_id).update(price: Faker::Number.decimal)

        expect(author.books.reload.first.price).not_to eq(book_price)
      end
    end
  end
end
