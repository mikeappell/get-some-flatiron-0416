class User < ActiveRecord::Base
  has_many :email_addresses
  has_many :organizations, through: :email_addresses
  has_many :user_orders
  has_many :orders, through: :user_orders
  has_many :admin_orders, class_name: "Order", foreign_key: "admin_id"
  has_many :items

  has_secure_password

  def sorted_recent_orders
    sorted_orders = orders.all.order(expiration: :desc)
    thing = sorted_orders.select { |order| (Time.now - order.expiration) < 300.days }
    # binding.pry
  end

end
