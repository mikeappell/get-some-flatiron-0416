class Order < ActiveRecord::Base
  has_many :user_orders
  has_many :users, through: :user_orders
  belongs_to :restaurant
  has_many :items
  belongs_to :organization
  belongs_to :admin, class_name: "User"
end
