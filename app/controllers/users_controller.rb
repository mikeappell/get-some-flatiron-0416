class UsersController < ApplicationController
  

  def show
    # will replace this with login specific 'before action'
    @user = User.all.first 
  end

  def index
  end

  def edit
  end
end
