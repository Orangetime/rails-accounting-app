class UsersController < ApplicationController
  skip_before_action :logged_in?, :only => [:new, :create, :index]
  before_action :current_user

  def index
    if current_user.actor.admin?
      @users = User.all
    else
      @users = User.employees
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new permitted_params
    user.save!

    actor = Actor::TYPES[params[:user][:role]].create(user_id: user.id)
    user.actor_id = actor.id
    user.actor_type = Actor::TYPES[params[:user][:role]]
    user.save!

    flash[:success] = ["Created a user with #{user.email} email" ]
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

    actor_type = params[:user][:actor_type]

    if Actor::TYPES.include?(actor_type) && actor_type != @user.actor_type
      @user.actor.destroy if @user.actor

      new_actor = Actor::TYPES[actor_type].create!(user_id: @user.id)
      @user.actor = new_actor
      @user.save!
    end

    flash[:success] = ["User updated" ]
    redirect_to auth_login_path
  end

  def assign_actor(actor_type)
    if Actor::TYPES.include?(actor_type)
    else
      raise "Unknown actor type: #{actor_type}"
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password, :first_name, :role)
  end
end
