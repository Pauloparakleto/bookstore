module ApplicationHelper
  def sign_in_or_sign_out_path
    return sign_out_path if user_signed_in?

    sign_in_path
  end

  def name_for_sign_in_or_sign_out
    return 'Sign out' if user_signed_in?

    'Sign in'
  end

  def path_to_block_or_unblock_customer(user)
    return block_customers_path(id: user.id) if user.unblocked?

    unblock_customers_path(id: user.id)
  end

  def name_to_block_or_unblock_customer(user)
    return 'Block Customer' if user.unblocked?

    'Unblock Customer'
  end
end
