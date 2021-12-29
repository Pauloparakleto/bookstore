module ApplicationHelper
  def sign_in_or_sign_out_path
    return sign_out_path if user_signed_in?

    sign_in_path
  end

  def name_for_sign_in_or_sign_out
    return 'Sign out' if user_signed_in?

    'Sign in'
  end
end
