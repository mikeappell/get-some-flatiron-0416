class User < ActiveRecord::Base
  has_many :email_addresses
  has_many :organizations, through: :email_addresses
  has_many :user_orders
  has_many :orders, through: :user_orders
  has_many :orders, foreign_key: "admin_id"
  has_many :items
end
