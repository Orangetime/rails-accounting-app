class ApplicationController < ActionController::Base
  before_action :logged_in?

  rescue_from ApplicationPolicy::ActionForbiddenErorr, with: :render_403

  def logged_in?
    unless current_user
      flash[:danger] = ['Unathorize user']
      redirect_to auth_root_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def render_403
    render 'errors/403'
  end
end
