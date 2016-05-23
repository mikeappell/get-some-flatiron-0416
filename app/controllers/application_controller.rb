class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # path = request.env['PATH_INFO']
    # binding.pry
    # if false @current_user
    # if [login_path, logout_path, root_path].include?(path) is false
    # unless [login_path, logout_path, root_path, sessions_path].include?(path)
    #   unless @current_user
    #     session[:user_id] = nil
    #     redirect_to login_path
    #   end
    # else 
    #   @current_user
    # end
  end

  def logged_in?
    !!current_user
  end
end
