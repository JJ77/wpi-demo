class RenameColumnInPlants < ActiveRecord::Migration
  def change
  	rename_column :plants, :descripton, :description
  end
end
