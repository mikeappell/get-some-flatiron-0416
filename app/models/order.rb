class Order < ActiveRecord::Base
  has_many :user_orders
  has_many :users, through: :user_orders
  has_many :items
  belongs_to :restaurant
  belongs_to :organization
  belongs_to :admin, class_name: "User"
  validates :minimum_cost, numericality: true, :format => { :with => /\A\d{1,6}(\.\d{0,2})?\z/ }

  def expired?
    (Time.zone.now - expiration) > 0
  end

  def set_order_params(restaurant, expiration, current_user)
    set_admin(current_user)
    set_date_ordered
    self.restaurant_id = restaurant.id
    self.expiration = expiration
  end

private
  def set_date_ordered
    self.date_ordered = Time.zone.now
  end

  def set_admin(current_user)
    self.admin_id = current_user.id
  end
end
