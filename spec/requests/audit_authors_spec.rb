require 'rails_helper'

RSpec.describe 'audit_authors/', type: :request do
  let!(:admin) { create(:admin) }
  let!(:author) { create(:author) }

  before do
    create_list(:audit_author, 2, admin: admin, author: author)
    sign_in admin
  end

  describe 'Index' do
    it 'renders successful' do
      get audit_authors_path
      expect(response).to be_successful
    end
  end
end
