class RegistrationMailer < ApplicationMailer

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email_addresses.last.email_address}>", :subject => "Registration Confirmation")
  end

  def email_confirmation(user, email)
    @user = user
    mail(:to => "#{user.name} <#{email}>", :subject => "Registration Confirmation")
  end

end
