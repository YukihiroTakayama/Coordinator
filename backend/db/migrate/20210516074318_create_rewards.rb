class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.float :amount, default: 0.0
      t.integer :user_id

      t.timestamps
    end
  end
end
