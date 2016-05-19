class Order < ActiveRecord::Base
  has_many :user_orders
  has_many :users, through: :user_orders
  has_many :items
  belongs_to :restaurant
  belongs_to :organization
  belongs_to :admin, class_name: "User"

  def expired? 
    (Time.zone.now - expiration) > 0
  end
end
