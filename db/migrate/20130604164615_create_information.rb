class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :name
      t.string :address
      t.string :tel
      t.string :fax
      t.string :email
      t.references :user

      t.timestamps
    end
    add_index :information, :user_id
  end
end
