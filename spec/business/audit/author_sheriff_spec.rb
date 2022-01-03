require 'rails_helper'

RSpec.describe Audit::AuthorSheriff do
  subject(:module_audit_author_only_last_name) {
    described_class.new(only_change_last_name_attribute,
                        { admin: admin, author: author })
  }

  let(:module_audit_author) {
    described_class.new(attributes_with_new_first_name,
                        { admin: admin, author: author })
  }
  let!(:attributes_with_new_first_name) {
    { first_name: 'another first name', last_name: author.last_name }
  }
  let!(:only_change_last_name_attribute) { { first_name: author.first_name, last_name: 'another last name' } }
  let(:admin) { create(:admin) }
  let(:author) { create(:author) }

  context 'when initialize' do
    it 'is truthy' do
      expect(module_audit_author).to be_truthy
    end

    it 'select author attributes' do
      expect(module_audit_author.author_attributes_to_compare).to eq({ first_name: author.first_name,
                                                                       last_name: author.last_name })
    end

    it 'returns the admin' do
      expect(module_audit_author.admin).to eq(admin)
    end

    it 'returns the author' do
      expect(module_audit_author.author).to eq(author)
    end
  end

  context 'when create AuditAuthor' do
    before do
      module_audit_author.create
    end

    it 'counts 1 audit author' do
      expect(AuditAuthor.count).to eq(1)
    end

    it 'has audit authors admin' do
      expect(AuditAuthor.last.admin).to eq(admin)
    end

    it 'has audit authors author' do
      expect(AuditAuthor.last.author).to eq(author)
    end

    it 'has first_name' do
      expect(AuditAuthor.last.first_name).to eq('another first name')
    end

    it 'has nil last_name' do
      expect(AuditAuthor.last.last_name).to be_nil
    end
  end

  context 'when change only last_name' do
    before do
      module_audit_author_only_last_name.create
    end

    it 'has first_name' do
      expect(AuditAuthor.last.first_name).to be_nil
    end

    it 'has nil last_name' do
      expect(AuditAuthor.last.last_name).to eq('another last name')
    end
  end

  context 'when there is no change!' do
    it 'does not create audit author' do
      sheriff = described_class.new({ first_name: author.first_name, last_name: author.last_name },
                                    { admin: admin, author: author })
      sheriff.create
      expect(AuditAuthor.count).to eq(0)
    end
  end
end
