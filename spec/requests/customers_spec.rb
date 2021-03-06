require 'rails_helper'

RSpec.describe '/customers', type: :request do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get customers_url
      expect(response).to be_successful
    end
  end

  describe 'Block User' do
    before do
      patch block_customers_path, params: { id: user.id }
    end

    it 'renders a successful response' do
      expect(response).to redirect_to(customers_path)
    end

    it 'has blocked user' do
      expect(user.reload.blocked?).to eq(true)
    end
  end

  describe 'Unblock Customer' do
    before do
      user.blocked!
      patch unblock_customers_path, params: { id: user.id }
    end

    it 'renders a successful response' do
      expect(response).to redirect_to(customers_path)
    end

    it 'has blocked user' do
      expect(user.reload.blocked?).to eq(false)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get customer_url(user)
      expect(response).to be_successful
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      expect {
        delete customer_url(user)
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete customer_url(user)
      expect(response).to redirect_to(customers_url)
    end
  end
end
