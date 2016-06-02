class UsersController < ApplicationController

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      RegistrationMailer.registration_confirmation(@user).deliver_now
      flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
      redirect_to login_path
    else
      flash.now[:alert] = "Signup Failed"
      render 'registrations/new'
    end
  end

  def index
  end

  def edit
    @email_address = EmailAddress.new
  end

  def update
    if params[:user][:username]
      if @current_user.update(username: params[:user][:username])
        redirect_to edit_user_path
      else
        render 'edit', alert: "The username you entered has already been taken"
      end
    elsif params[:user][:password] && params[:user][:password_confirmation]
      if @current_user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        redirect_to edit_user_path
      else
        render 'edit', alert: "The field you entered was incorrect"
      end
    elsif params[:user][:venmo]
      if @current_user.update(venmo: params[:user][:venmo])
        redirect_to edit_user_path
      else
        render 'edit', alert: "The field you entered was incorrect"
      end
    else
      render "edit", alert: "The highlighted field was entered incorrectly"
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:confirmation_token])
    if user
      user.email_activate
      session[:user_id] = user.id
      flash[:success] = "Your email has been successfully registered. Welcome to the GetSome™ Lunch!"
      redirect_to manage_organizations_path(user)
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_path
    end
  end

  def current_user_id
    user_id = session[:user_id]
    render json: { id: user_id }
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :username, :venmo, email_addresses_attributes: [:email_address])
  end
end
