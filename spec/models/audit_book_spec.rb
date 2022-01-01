require 'rails_helper'

RSpec.describe AuditBook, type: :model do
  subject(:audit_book) { described_class.new }

  describe 'attributes' do
    it 'book_id' do
      expect(audit_book).to have_db_column(:book_id).with_options(null: false).of_type(:integer)
    end

    it 'admin_id' do
      expect(audit_book).to have_db_column(:admin_id).with_options(null: false).of_type(:integer)
    end

    it 'title' do
      expect(audit_book).to have_db_column(:title).of_type(:string)
    end

    it 'quantity' do
      expect(audit_book).to have_db_column(:quantity).of_type(:integer)
    end

    it 'published' do
      expect(audit_book).to have_db_column(:published).of_type(:boolean)
    end

    it 'price' do
      expect(audit_book).to have_db_column(:price).with_options(precision: 10, scale: 2).of_type(:decimal)
    end
  end

  describe 'associations' do
    it 'belongs to admin' do
      expect(audit_book).to belong_to(:admin)
    end

    it 'belongs to book' do
      expect(audit_book).to belong_to(:book)
    end
  end
end
