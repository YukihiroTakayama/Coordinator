class CreateParts < ActiveRecord::Migration[6.1]
  def change
    create_table :parts do |t|
      t.integer :place
      t.string  :item_code
      t.integer :coordinate_id

      t.timestamps
    end
  end
end
