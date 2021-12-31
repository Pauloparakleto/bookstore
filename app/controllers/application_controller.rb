class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    return root_path if resource.is_a? Admin

    check_blocked_user(resource)
    users_root_path
  end

  private

  def check_blocked_user(resource)
    return unless resource.blocked?

    sign_out resource
    flash[:alert] = 'You are blocked, please contact support'
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_resource_or_scope)
    users_root_path
  end
end
