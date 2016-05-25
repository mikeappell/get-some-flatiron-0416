class RegistrationMailer < ApplicationMailer

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email_addresses.last.email_address}>", :subject => "Registration Confirmation")
  end

  def email_confirmation(user, email)
    @user = user
    @email = email
    mail(:to => "#{user.name} <#{email.email_address}>", :subject => "New Email Confirmation")
  end

  def order_placed(recipients, admin)
    @admin = admin

    mail(
      bcc: recipients,
      subject: "Your Order Has Been Placed!"
    )
  end

  def order_arrived(recipients, admin)
    @admin = admin

    mail(
    bcc: recipients,
    subject: "Your Order Has Arrived!"
    )
  end



  end
end
