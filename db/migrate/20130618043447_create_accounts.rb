class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :content
      t.integer :price
      t.string :note
      t.references :item

      t.timestamps
    end
    add_index :accounts, :item_id
  end
end
