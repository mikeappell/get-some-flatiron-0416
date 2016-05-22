class AddEmailStuffToEmailAddresses < ActiveRecord::Migration
  def change
    add_column :email_addresses, :email_confirmed, :boolean, default: false
    add_column :email_addresses, :confirm_token, :string
  end
end
