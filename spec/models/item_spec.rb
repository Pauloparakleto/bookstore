require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    subject(:item) { described_class.create(attributes_for(:item, book_id: book.id)) }

    let!(:book) { create(:book) }

    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  end

  context 'when create invalid' do
    it 'has invalid quantity zero' do
      book = create(:book)
      item = build(:item, quantity: 0, book: book)
      item.save
      expect(item.errors.full_messages.first).to eq('Quantity must be greater than or equal to 1')
    end
  end
end
