class SendEmailsController < ApplicationController

  def order_placed
    # binding.pry
    order = Order.find(params[:order_id])
    users = order.users
    organization = order.organization
    admin = order.admin

    recipient_list = recipients(users, organization)
    RegistrationMailer.order_placed(recipient_list, admin).deliver_now
  end

  def order_arrived
    # binding.pry
    order = Order.find(params[:order_id])
    users = order.users
    organization = order.organization
    admin = order.admin

    recipient_list = recipients(users, organization)
    RegistrationMailer.order_arrived(recipient_list, admin).deliver_now
  end

  private

  def recipients(users, organization)
    recipient_list = []
    users.each do |user|
      user.email_addresses.each do |email_address|
        if email_address.email_address.split('@')[1] == organization.domain_name
          recipient_list << email_address.email_address
        end
      end
    end
    recipient_list
  end
end
