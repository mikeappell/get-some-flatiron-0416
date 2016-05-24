class AddGroupIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :group_id, :integer, index: true
  end
end
