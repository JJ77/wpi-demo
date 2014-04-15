class Bed < ActiveRecord::Base
  before_save :set_location
  belongs_to :greenhouse
  belongs_to :location

  private

  	def set_location
  		self.location_id = Greenhouse.find(self.greenhouse_id).location_id
  	end
end
