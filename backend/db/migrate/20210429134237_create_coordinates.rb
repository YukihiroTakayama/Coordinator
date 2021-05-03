class CreateCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinates do |t|
      t.integer :user_id
      t.text :caption
      t.integer :image_id
      t.string :title

      t.timestamps
    end
  end
end
