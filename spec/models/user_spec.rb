require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  context 'when create' do
    it 'has email' do
      expect(user.email).to be_truthy
    end
  end
end
