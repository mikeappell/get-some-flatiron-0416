class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def show
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Signup Failed"
      render 'registrations/new'
    end
  end

  def index
  end

  def edit
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :username, :venmo)
  end
end
