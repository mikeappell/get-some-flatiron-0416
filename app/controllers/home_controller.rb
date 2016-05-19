class HomeController < ApplicationController
  def home
    if !session[:user_id].nil?
      redirect_to user_path(current_user)
    else
      render 'home'
    end
  end
end
