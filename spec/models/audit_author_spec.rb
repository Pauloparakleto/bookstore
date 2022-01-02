require 'rails_helper'

RSpec.describe AuditAuthor, type: :model do
  subject(:audit_author) { described_class.new }

  describe 'attributes' do
    it 'author_id' do
      expect(audit_author).to have_db_column(:author_id).with_options(null: false).of_type(:integer)
    end

    it 'admin_id' do
      expect(audit_author).to have_db_column(:admin_id).with_options(null: false).of_type(:integer)
    end

    it 'first_name' do
      expect(audit_author).to have_db_column(:first_name).of_type(:string)
    end

    it 'last_name' do
      expect(audit_author).to have_db_column(:last_name).of_type(:string)
    end
  end

  describe 'associations' do
    it 'belongs to admin' do
      expect(audit_author).to belong_to(:admin)
    end

    it 'belongs to author' do
      expect(audit_author).to belong_to(:author)
    end
  end
end
