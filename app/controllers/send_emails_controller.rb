class SendEmailsController < ApplicationController

  def order_placed
    order_id = params[:order_id]
    recipients = EmailOrderInfo.get_recipients(order_id)
    admin = EmailOrderInfo.get_admin(order_id)

    RegistrationMailer.order_placed(recipients, admin).deliver_now
  end

  def order_arrived
    order_id = params[:order_id]
    recipients = EmailOrderInfo.get_recipients(order_id)
    admin = EmailOrderInfo.get_admin(order_id)

    RegistrationMailer.order_arrived(recipients, admin).deliver_now
  end

end
