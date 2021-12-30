class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    if _resource.is_a? User
      users_root_path
    elsif _resource.is_a? Admin
      root_path
    else
      users_root_path
    end
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_resource_or_scope)
    users_root_path
  end
end
