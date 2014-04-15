class CreateProjections < ActiveRecord::Migration
  def change
    create_table :projections do |t|
      t.references :plant, index: true
      t.references :entry, index: true
      t.integer :pots
      t.integer :finish_week
      t.integer :delay_week

      t.timestamps
    end
  end
end
