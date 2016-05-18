class AddOrganizationIdToEmailAddresses < ActiveRecord::Migration
  def change
    add_column :email_addresses, :organization_id, :integer
  end
end
