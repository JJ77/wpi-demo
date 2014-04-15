class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :pots
      t.integer :stick_week
      t.integer :hang_week
      t.integer :finish_week
      t.integer :rating
      t.integer :status
      t.references :plant, index: true
      t.references :bed, index: true
      t.references :greenhouse, index: true
      t.references :location, index: true

      t.timestamps
    end
  end
end
