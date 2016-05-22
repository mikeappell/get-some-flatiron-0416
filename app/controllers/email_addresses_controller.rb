class EmailAddressesController < ApplicationController
  def new
  end

  def create
    domain = /@(\w+)/.match(params[:email_address][:email_address])
    if !!@organization = Organization.find_by(domain_name: domain[1])
      @email_address = EmailAddress.new(email_address: params[:email_address][:email_address], user_id: @current_user.id, organization_id: @organization.id)
      if @email_address.save
        RegistrationMailer.email_confirmation(@current_user, @email_address).deliver
        flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
        redirect_to edit_user_path(@current_user)
      else
        render 'users/edit', alert: "That Email is not valid"
      end
    else
      @organization = Organization.create(domain_name: domain[1])
      @email_address = EmailAddress.new(email_address: params[:email_address][:email_address], user_id: @current_user.id, organization_id: @organization.id)
      if @email_address.save
        RegistrationMailer.email_confirmation(@current_user, @email_address).deliver
        flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
        redirect_to edit_user_path(@current_user)
      else
        render 'users/edit', alert: "That Email is not valid"
      end
    end

  end

  def edit
  end
end
