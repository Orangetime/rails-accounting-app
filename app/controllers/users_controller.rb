class UsersController < ApplicationController
  skip_before_action :logged_in?, :only => [:new, :create, :index]

  def index
    @users = User.where(first_name: nil)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new permitted_params
    user.save!
    flash[:success] = ['New user added']
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(permitted_params)
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password, :first_name)
  end
end
