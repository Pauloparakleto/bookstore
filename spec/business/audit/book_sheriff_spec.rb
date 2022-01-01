require 'rails_helper'

RSpec.describe Audit::BookSheriff do
  subject(:module_audit_book) {
    described_class.new(attributes_with_new_title,
                        { admin: admin, book: book })
  }

  let!(:attributes_with_new_title) { { title: 'another title', price: book.price, quantity: 1 } }
  let(:admin) { create(:admin) }
  let(:book) { create(:book) }

  context 'when initialize' do
    it 'is truthy' do
      expect(module_audit_book).to be_truthy
    end

    it 'select book attributes' do
      expect(module_audit_book.book_attributes_to_compare).to eq({ title: book.title, quantity: book.quantity,
                                                                   price: book.price })
    end

    it 'returns new title' do
      module_audit_book.set_title_difference
      expect(module_audit_book.title).to eq('another title')
    end

    it 'returns new quantity' do
      module_audit_book.set_quantity_difference
      expect(module_audit_book.quantity).to eq(1)
    end

    it 'returns price nil' do
      module_audit_book.set_price_difference
      expect(module_audit_book.price).to be_nil
    end

    it 'returns the admin' do
      expect(module_audit_book.admin).to eq(admin)
    end

    it 'returns the book' do
      expect(module_audit_book.book).to eq(book)
    end
  end

  context 'when create AuditBook' do
    before do
      module_audit_book.create
    end

    it 'counts 1 audit book' do
      expect(AuditBook.count).to eq(1)
    end

    it 'has audit books admin' do
      expect(AuditBook.last.admin).to eq(admin)
    end

    it 'has audit books book' do
      expect(AuditBook.last.book).to eq(book)
    end

    it 'has title' do
      expect(AuditBook.last.title).to eq('another title')
    end

    it 'has nil price' do
      expect(AuditBook.last.price).to be_nil
    end

    it 'has nil quantity' do
      expect(AuditBook.last.quantity).to eq(1)
    end
  end
end
