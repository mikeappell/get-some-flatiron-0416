class Organization < ActiveRecord::Base

  has_many :email_addresses
  has_many :users, through: :email_addresses
  has_many :orders
  has_many :groups

  def org_sorted_recent_orders
    sorted_orders = orders.all.order(expiration: :asc)
    thing = sorted_orders.select { |order| (Time.zone.now - order.expiration) < 12.hours }
  end
end
