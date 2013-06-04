class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.string :note
      t.string :client_name
      t.string :state
      t.datetime :estimated_at
      t.datetime :ordered_at
      t.datetime :deliveried_at
      t.datetime :receipted_at
      t.references :user

      t.timestamps
    end
    add_index :items, :user_id
  end
end
