class ApplicationController < ActionController::Base
  before_action :logged_in?

  def logged_in?
    unless current_user
      flash[:danger] = ['Unathorize user']
      redirect_to auth_root_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end
end
