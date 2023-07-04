class Auth::LoginsController < ApplicationController
  skip_before_action :logged_in?

  def new; end

  def create
    user = User.find_by(email: permitted_params[:email])
    if user && user.password == permitted_params[:password]
      session[:current_user_id] = user.id

      flash[:success] = ['You are logged in']
      redirect_to users_path
    else
      flash[:danger] = ['Unathorize user']
      redirect_to auth_login_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    flash[:success] = ['You are logged out']
    redirect_to auth_login_path
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end
