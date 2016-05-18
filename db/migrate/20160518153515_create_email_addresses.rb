class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.integer :user_id
      t.string :organization_id
      t.string :integer
      t.string :email_address

      t.timestamps null: false
    end
  end
end
