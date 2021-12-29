class CustomersController < ApplicationController
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
    redirect_to customers_path, notice: 'User was blocked!'
  end

  private

  def user_params
    params.require(:user).permit(:id)
  end
end
