class Entry < ActiveRecord::Base
  belongs_to :plant
  belongs_to :bed
  belongs_to :greenhouse
  belongs_to :location
  before_save :set_greenhouse, :set_location
  before_create :set_finish_week, :set_status


  def current_week
      # Returns an integer representation of current week in year
      Time.now.strftime("%U").to_i + 1
    end

  private

  	def set_greenhouse
  		self.greenhouse_id = Bed.find(self.bed_id).greenhouse_id
  	end

  	def set_location
  		self.location_id = Greenhouse.find(Bed.find(self.bed_id).greenhouse_id).location_id
  	end

  	def set_finish_week
  		week_array = (1..52).to_a
      finishtime = Plant.find(self.plant_id).finishtime[self.stick_week]
      week_array.rotate!(week_array.index(self.stick_week) + finishtime.to_i)
      self.finish_week = week_array[0]
  	end

    def set_status
      self.status = 0
    end


end
