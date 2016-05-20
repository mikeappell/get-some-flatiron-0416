class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      RegistrationMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
      redirect_to login_path
    else
      flash[:alert] = "Signup Failed"
      render 'registrations/new'
    end
  end

  def index
  end

  def edit
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:confirmation_token])
    if user 
      user.email_activate
      session[:user_id] = user.id
      flash[:success] = "Your registration has been successful. Welcome to the GetSome™ Lunch!"
      redirect_to manage_organizations_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_path
    end
end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :username, :venmo, email_addresses_attributes: [:email_address])
  end
end
