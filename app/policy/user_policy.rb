class UserPolicy < ApplicationPolicy
  def edit? = @current_user.actor.admin?

  def reset_password? = @current_user.actor.admin?

  def update? = edit?
end