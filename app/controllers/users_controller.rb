class UsersController < ApplicationController
  before_action :require_signin, except: [ :new, :create ]
  before_action :require_author, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @registrations = @user.registrations
    @liked_events = @user.liked_events
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "User successfully created!"
    else
      flash[:alert] = "The user cannot be created. Try again."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User successfully updated!"
    else
      flash[:alert] = "The user cannot be updated. Try again."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil

    if @user.destroy
      redirect_to users_path, notice: "User successfully deleted."
    else
      render @user, status: :unprocessable_entity
    end
  end

  private

  def require_author
    @user = User.find params[:id]
    unless @user == current_user
      redirect_to events_url
    end
  end

  def user_params
    params.require(:user).permit(
      :id,
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
