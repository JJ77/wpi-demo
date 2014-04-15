class CreateGreenhouses < ActiveRecord::Migration
  def change
    create_table :greenhouses do |t|
      t.string :name
      t.string :description
      t.references :location, index: true

      t.timestamps
    end
  end
end
