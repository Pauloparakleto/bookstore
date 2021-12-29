require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'has a block path' do
    user = create(:user)
    path = block_customers_path(user)
    expect(helper.path_to_block_or_unblock_customer(user)).to eq(path)
  end

  it 'has an unblock path' do
    user = create(:user)
    user.blocked!
    path = unblock_customers_path(user)
    expect(helper.path_to_block_or_unblock_customer(user)).to eq(path)
  end
end
