class RemoveEmailConfirmedFromEmailAddresses < ActiveRecord::Migration
  def change
    remove_column :email_addresses, :email_confirmed, :boolean
  end
end
