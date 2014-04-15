class Projection < ActiveRecord::Base
  belongs_to :plant
  belongs_to :entry
  before_save :set_finish_week

  def parent
  	Entry.find(self.entry_id)
  end

  def parent_plant
  	Plant.find(self.parent.plant_id)
  end

  private

  	def set_finish_week
  		week_array = (1..52).to_a
  		finishtime = self.parent_plant.finishtime[self.stick_week]
  		finishtime *= 1.22
  		week_array.rotate!(week_array.index(self.stick_week + finishtime))
  		self.finish_week = week_array[0]
  	end
end
