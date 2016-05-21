class AddConfirmedToEmailAddresses < ActiveRecord::Migration
  def change
    add_column :email_addresses, :confirmed, :boolean
  end
end
