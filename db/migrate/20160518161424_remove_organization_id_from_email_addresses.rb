class RemoveOrganizationIdFromEmailAddresses < ActiveRecord::Migration
  def change
    remove_column :email_addresses, :organization_id, :string
  end
end
