class RemoveIntegerFromEmailAddresses < ActiveRecord::Migration
  def change
    remove_column :email_addresses, :integer, :string
  end
end
