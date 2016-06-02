class EmailAddressesController < ApplicationController
  def new
  end

  def create
    @organization = OrganizationFinder.find_or_create(email_params)
    @email_address = EmailAddress.new(email_address: email_params, user_id: current_user.id, organization_id: @organization.id)
    if @email_address.save
      RegistrationMailer.email_confirmation(current_user, @email_address).deliver_now
      flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
      redirect_to edit_user_path(current_user)
    else
      render 'users/edit', alert: "That Email is not valid"
    end
  end

  def confirm_email
    email = EmailAddress.find_by_confirm_token(params[:confirmation_token])
    if email
      email.email_address_activate
      flash[:success] = "Your email has been successfully added."
      redirect_to manage_organizations_path(@current_user)
    else
      flash[:error] = "Sorry. That confirmation code didn't work."
      redirect_to root_path
    end
  end

  def edit
  end

  private

    def email_params
      params.require(:email_address).permit(:email_address)[:email_address]
    end
end
