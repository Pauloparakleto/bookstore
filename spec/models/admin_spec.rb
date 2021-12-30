require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject(:admin) { create(:admin) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  context 'when create' do
    it 'has email' do
      expect(admin.email).to be_truthy
    end
  end
end
