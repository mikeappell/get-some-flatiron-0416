class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])

    # path = request.env['PATH_INFO']
    # if @current_user.nil? && ![login_path, logout_path, root_path, signup_path, sessions_path].include?(path)
    #   session[:user_id] = nil
    #   redirect_to login_path
    # else
    #   @current_user
    # end
  end

  def logged_in?
    !!current_user
  end
end
