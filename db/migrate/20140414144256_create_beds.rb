class CreateBeds < ActiveRecord::Migration
  def change
    create_table :beds do |t|
      t.string :name
      t.string :capacity
      t.references :greenhouse, index: true
      t.references :location, index: true

      t.timestamps
    end
  end
end
