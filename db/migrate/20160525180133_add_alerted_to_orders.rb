class AddAlertedToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :alerted, :boolean, default: false
  end
end
