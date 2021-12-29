require 'rails_helper'

RSpec.describe ::ShoppingCart do
  it 'has an empty items' do
    cart = ShoppingCart.new()
    expect(cart.items).to eq([])
  end
end
