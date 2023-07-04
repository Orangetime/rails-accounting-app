class ResetPasswordsController < ApplicationController
  def edit
    @user = User.find_by(id: params[:id])

    UserPolicy.authorize!(current_user, @user, :reset_password)
  end

  def update
    @user = User.find_by(id: params[:id])

    UserPolicy.authorize!(current_user, @user, :reset_password)

    @user.update!(permitted_params)
  end

  def permitted_params
    params.require(:user).permit(:password)
  end
end