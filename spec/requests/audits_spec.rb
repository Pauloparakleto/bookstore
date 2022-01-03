require 'rails_helper'

RSpec.describe 'audits/', type: :request do
  let!(:admin) { create(:admin) }
  let!(:book) { create(:book) }

  before do
    create_list(:audit_book, 2, admin: admin, book: book)
    sign_in admin
  end

  describe 'Index' do
    it 'renders successful' do
      get audits_path
      expect(response).to be_successful
    end
  end
end
