module Sortable
  def sorted_recent_orders
    sorted_orders = orders.all.order(expiration: :desc)
    thing = sorted_orders.select { |order| (Time.now - order.expiration) < 300.days }
  end
end