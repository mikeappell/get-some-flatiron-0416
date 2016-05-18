class UsersController < ApplicationController
  

  def show
    # will replace this with login specific 'before action'
    @user = User.find(params[:id]) 
  end

  def index
  end

  def edit
  end
end
