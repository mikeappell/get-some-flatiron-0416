class Order < ActiveRecord::Base
  has_many :items
  has_many :users, through: :items
  has_many :messages
  belongs_to :restaurant
  belongs_to :organization
  belongs_to :admin, class_name: "User"
  belongs_to :group
  validates :minimum_cost, numericality: true, :format => { :with => /\A\d{1,6}(\.\d{0,2})?\z/ }
  validates :organization_id, presence: true
  validates :expiration, presence: true
  validates :minimum_cost, presence: true
  validates :restaurant, presence: true
  # validates :group_id, presence: true

  def self.seed_image 
    image_array = Dir["app/assets/images/*"].select {|image| image.include?("order-image")}
    select_random_image = /.+\/(.+)/.match(image_array[rand(image_array.size)])[1]
  end

  def random_image
    image_array = Dir["app/assets/images/*"].select {|image| image.include?("order-image")}
    select_random_image = /.+\/(.+)/.match(image_array[rand(image_array.size)])[1]
    self.image_url = select_random_image
  end
  def expired?
    (Time.zone.now - expiration) > 0
  end

  def set_order_params(restaurant, expiration, current_user)
    set_admin(current_user)
    set_date_ordered
    self.restaurant_id = restaurant.id
    self.expiration = expiration
  end

  def minimum_cost_formatted
    split_cost = self.minimum_cost.to_s.split(".")
    split_cost[1] = split_cost[1].ljust(2,"0")
    split_cost.join(".")
  end

  def item_total
    items.sum(:cost).to_f
  end

  def item_total_formatted
    split_cost = self.items.sum(:cost).to_s.split(".")
    split_cost[1] = split_cost[1].ljust(2,"0")
    split_cost.join(".")
  end

  def cost_remaining
    split_cost = (self.minimum_cost - self.item_total).to_s.split(".")
    split_cost[1] = split_cost[1].ljust(2,"0")
    split_cost.join(".")
  end

  def order_you_can_join?(current_user)
    !self.expired? && current_user.groups.include?(self.group) && !current_user.orders.include?(self) && !current_user.admin_orders.include?(self)
  end

private
  def set_date_ordered
    self.date_ordered = Time.zone.now
  end

  def set_admin(current_user)
    self.admin_id = current_user.id
  end

end
