class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :item_code
      t.string :descripton
      t.text :finishtime
      t.text :expiration
      t.integer :parent_plant_id

      t.timestamps
    end
  end
end
