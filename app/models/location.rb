class Location < ActiveRecord::Base
	has_many :greenhouses
	has_many :beds

	  # Array of all beds in location
  def beds
  	Bed.where(location_id:self.id)
  end

  #All entries for specific location that are history
  def history
  	Entry.where(status:1, location_id:self.id)
  end

  #All entries for specific location that are current
  def current
  	Entry.where(status:0, location_id:self.id)
  end

  # Total plants in location
  def total
  	self.current.pluck(:pots).inject(:+)
  end

  def capacity
  	self.beds.pluck(:capacity).inject(:+)
  end
end
