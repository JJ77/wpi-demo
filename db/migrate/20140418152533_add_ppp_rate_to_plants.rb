class AddPppRateToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :ppprate, :integer, default:1
  end
end
