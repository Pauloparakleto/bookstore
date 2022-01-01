require 'rails_helper'

RSpec.describe Audit::BookSheriff do
  subject(:module_audit_book_only_price) {
    described_class.new(only_change_price_attribute,
                        { admin: admin, book: book })
  }

  let(:module_audit_book) {
    described_class.new(attributes_with_new_title,
                        { admin: admin, book: book })
  }
  let!(:attributes_with_new_title) { { title: 'another title', price: book.price, quantity: 1 } }
  let!(:only_change_price_attribute) { { title: book.title, price: 233, quantity: book.quantity } }
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

  context 'when change only price' do
    before do
      module_audit_book_only_price.create
    end

    it 'has title' do
      expect(AuditBook.last.title).to be_nil
    end

    it 'has nil price' do
      expect(AuditBook.last.price).to eq(233)
    end

    it 'has nil quantity' do
      expect(AuditBook.last.quantity).to be_nil
    end
  end
end
