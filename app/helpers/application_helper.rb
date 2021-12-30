module ApplicationHelper
  def root_for_resource
    return root_path if admin_signed_in?

    users_root_path
  end

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

  def enter_leave_admin_area
    return new_admin_session_path unless admin_signed_in?

    sign_out_path
  end

  def link_name_leave_or_enter_admin_area
    return 'Enter Admin Area' unless admin_signed_in?

    'Leave Admin Area'
  end
end
