class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    users_root_path
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_resource_or_scope)
    users_root_path
  end
end
