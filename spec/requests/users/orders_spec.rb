require 'rails_helper'

RSpec.describe '/users/orders' do
  describe 'GETS cart' do
    it 'redirects to users books' do
      get cart_users_orders_path
      expect(response).to be_successful
    end
  end
end
