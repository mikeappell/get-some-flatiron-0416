module Sortable
  def sorted_recent_orders
    sorted_orders = orders.all.order(expiration: :desc)
    thing = sorted_orders.select { |order| (Time.zone.now - order.expiration) < 12.hours }
  end

  
end