class CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to customers_path, notice: 'User was deleted!'
  end

  def block
    @user = User.find(params[:id])
    @user.blocked!
    redirect_to customers_path, notice: 'Customer was blocked!'
  end

  def unblock
    @user = User.find(params[:id])
    @user.unblocked!
    redirect_to customers_path, notice: 'Customer was unblocked!'
  end

  private

  def user_params
    params.require(:user).permit(:id)
  end
end
