class RegistrationsController < ApplicationController
  def new
    @user = User.new
    @email_addresses = @user.email_addresses.build
  end
end
