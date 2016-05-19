class AddIndexes < ActiveRecord::Migration
  def change
    add_index :email_addresses, :user_id
    add_index :email_addresses, :organization_id
    add_index :items, :order_id
    add_index :items, :user_id
    add_index :orders, :organization_id
    add_index :orders, :admin_id
    add_index :orders, :restaurant_id
    add_index :user_orders, :user_id
    add_index :user_orders, :order_id
  end
end
