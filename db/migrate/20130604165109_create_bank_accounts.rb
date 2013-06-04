class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.string :branch_name
      t.string :branch_number
      t.string :name
      t.string :code
      t.string :type
      t.references :user

      t.timestamps
    end
    add_index :bank_accounts, :user_id
  end
end
