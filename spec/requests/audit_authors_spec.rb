require 'rails_helper'

RSpec.describe 'audit_authors/', type: :request do
  let!(:admin) { create(:admin) }

  before do
    create(:author)
    create_list(:audit_author, 2)
    sign_in admin
  end

  describe 'Index' do
    it 'renders successful' do
      get audit_authors_path
      expect(response).to be_successful
    end
  end
end
