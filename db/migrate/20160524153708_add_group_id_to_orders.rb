class AddGroupIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :group, foreign_key: true
  end
end
