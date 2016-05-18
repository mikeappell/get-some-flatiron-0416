class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :organization_id
      t.datetime :date_ordered
      t.datetime :expiration
      t.integer :admin_id
      t.integer :restaurant_id

      t.timestamps null: false
    end
  end
end
