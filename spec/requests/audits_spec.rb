require 'rails_helper'

RSpec.describe 'audits/', type: :request do
  let!(:admin) { create(:admin) }

  before do
    create(:book)
    create_list(:audit_book, 2)
    sign_in admin
  end

  describe 'Index' do
    it 'renders successful' do
      get audits_path
      expect(response).to be_successful
    end
  end
end
