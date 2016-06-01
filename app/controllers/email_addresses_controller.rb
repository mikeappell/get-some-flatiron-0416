class EmailAddressesController < ApplicationController
  def new
  end

  def create
    #find domain name
    domain = /@(.+)/.match(params[:email_address][:email_address])
    #find an organization by domain name. if organization if found...
    if !!@organization = Organization.find_by(domain_name: domain[1])
      #make new email address and associate current user with it
      @email_address = EmailAddress.new(email_address: params[:email_address][:email_address], user_id:
     current_user.id, organization_id: @organization.id)
     # if legit email address
      if @email_address.save
        #send confirmation email and flash notice. redirect to edit user path
        RegistrationMailer.email_confirmation(current_user, @email_address).deliver_now
        flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
        redirect_to edit_user_path(current_user)
      else
    # if not legit address, redirect with email not valid
        render 'users/edit', alert: "That Email is not valid"
      end
    else
    # else if not organization was found, create a new one
      @organization = Organization.create(domain_name: domain[1])
    #create new email address and associate current user with it
      @email_address = EmailAddress.new(email_address: params[:email_address][:email_address], user_id: current_user.id, organization_id: @organization.id)
    # if legit email address
      if @email_address.save
        #send confirmation email and flash notice. redirect to edit user path
        RegistrationMailer.email_confirmation(current_user, @email_address).deliver_now
        flash[:notice] = "Almost there! Please click the link in your email to complete your registration"
        redirect_to edit_user_path(current_user)
      else
      # if not legit address, redirect with email not valid
        render 'users/edit', alert: "That Email is not valid"
      end
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
end
