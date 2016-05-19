class User < ActiveRecord::Base
  include Sortable
  has_many :email_addresses
  has_many :organizations, through: :email_addresses
  has_many :user_orders
  has_many :orders, through: :user_orders
  has_many :admin_orders, class_name: "Order", foreign_key: "admin_id"
  has_many :items

  has_secure_password

end
