class SendEmailsController < ApplicationController

  def order_confirmation
    order = Order.find(params[:order_id])
    users = order.users
    organization = order.organization
    admin = order.admin

    recipients = recipients(users, organization)
    RegistrationMailer.order_placed(recipients, admin).deliver_now
  end

  private

    def recipients(users, organization)
      users.each do |user|
        user.email_addresses do |email_address|
          if email_address.email_address.split('@')[1] == organization.domain_name
            recipients << email_address.email_address
          end
        end
      end
      recipients
    end
end
