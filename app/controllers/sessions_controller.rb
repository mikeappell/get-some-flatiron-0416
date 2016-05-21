class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:alert] = "Please activate your account using the link in your email."
        render :new
      end
    else
      flash[:alert] = "Login Failed."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
