class AddOrderPlacedAndImageUrlToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :placed, :boolean, default: false
    add_column :orders, :image_url, :string
  end
end