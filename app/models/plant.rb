class Plant < ActiveRecord::Base
	serialize :expiration
	serialize :finishtime
	has_many :child_plants, :class_name => "Plant", :foreign_key => "parent_plant_id"
	belongs_to :parent, :class_name => "Plant", :foreign_key => "parent_plant_id"

end
