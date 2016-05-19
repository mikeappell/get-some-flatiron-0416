class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def sorted_recent_orders
    sorted_orders = orders.all.order(expiration: :desc)
    thing = sorted_orders.select { |order| (Time.now - order.expiration) < 300.days }
  end
end
