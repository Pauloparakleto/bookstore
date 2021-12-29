module Users
  class UsersController < ApplicationController
    before_action :authenticate_user!
  end
end
