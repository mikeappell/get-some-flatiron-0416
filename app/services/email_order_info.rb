class EmailOrderInfo

  def self.get_recipients(order_id)
    order = Order.find(order_id)
    users = order.users
    organization = order.organization
    recipients(users, organization)
  end

  def self.get_admin(order_id)
    Order.find(order_id).admin
  end

  private
  
  def self.recipients(users, organization)
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
