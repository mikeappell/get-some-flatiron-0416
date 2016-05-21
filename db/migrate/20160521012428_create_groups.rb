class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :organization, index: true, foreign_key: true
    end
  end
end
