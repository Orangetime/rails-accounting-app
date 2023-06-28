class UsersController < ApplicationController
  skip_before_action :logged_in?, :only => [:new, :create, :index]
  before_action :current_user

  def index
    @users = User.all
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

    UserPolicy.authorize!(current_user, @user, :edit)
  end

  def update
    @user = User.find(params[:id])

    UserPolicy.authorize!(current_user, @user, :update)

    @user.update!(permitted_params)
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password, :first_name)
  end
end
