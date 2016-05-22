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

  def set_order_params(restaurant, expiration, current_user)
    set_admin(current_user)
    set_date_ordered
    self.restaurant_id = restaurant.id
    self.expiration = expiration
  end

  # def minimum_cost=(cost)
    
  # end

private

  def set_date_ordered
    self.date_ordered = Time.now
  end

  def set_admin(current_user)
    self.admin_id = current_user.id
  end
end
