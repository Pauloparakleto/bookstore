require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'when create invalid' do
    it 'has invalid quantity zero' do
      item = build(:item, quantity: 0)
      item.save
      expect(item.errors.full_messages.first).to eq('Quantity must be greater than or equal to 1')
    end
  end
end
