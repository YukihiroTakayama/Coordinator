class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :user_id
      t.boolean :is_paid, default: false
      t.string :transfer_group

      t.timestamps
    end
  end
end
