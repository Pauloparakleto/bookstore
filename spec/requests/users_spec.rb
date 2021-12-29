require 'rails_helper'

RSpec.describe '/users', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get users_url
      expect(response).to be_successful
    end
  end

  describe 'Block User' do
    before do
      patch block_users_path, params: { id: user.id }
    end

    it 'renders a successful response' do
      expect(response).to redirect_to(users_path)
    end

    it 'has blocked user' do
      expect(user.reload.blocked?).to eq(true)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
