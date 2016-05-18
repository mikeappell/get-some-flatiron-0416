class AddDescriptionAndMinimumCostToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :description, :string
    add_column :orders, :minimum_cost, :decimal
  end
end
