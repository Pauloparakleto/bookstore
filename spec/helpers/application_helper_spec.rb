require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'path to block or unblock' do
    it 'has a block path' do
      user = create(:user)
      path = block_customers_path(id: user.id)
      expect(helper.path_to_block_or_unblock_customer(user)).to eq(path)
    end

    it 'has an unblock path' do
      user = create(:user)
      user.blocked!
      path = unblock_customers_path(id: user.id)
      expect(helper.path_to_block_or_unblock_customer(user)).to eq(path)
    end
  end

  describe 'name to block or unblock' do
    it 'has a block path' do
      user = create(:user)
      name = 'Block Customer'
      expect(helper.name_to_block_or_unblock_customer(user)).to eq(name)
    end

    it 'has an unblock path' do
      user = create(:user)
      user.blocked!
      name = 'Unblock Customer'
      expect(helper.name_to_block_or_unblock_customer(user)).to eq(name)
    end
  end
end
