class Projection < ActiveRecord::Base
  belongs_to :plant
  belongs_to :entry
  before_save :set_finish_week
  before_create :set_delay_week


  # Returns an integer representation of current week in year
  def current_week
    Time.now.strftime("%U").to_i + 1
  end

  # Returns a projections parent entry
  def parent
  	Entry.find(self.entry_id)
  end


  # Returns a projection's parent plant
  def parent_plant
  	Plant.find(self.parent.plant_id)
  end

  # Returns a pot count of all projected plants from passed parent plant.
  # Defaults to zero if none found.
  def self.projected_pots_by_parent(parent_id, finish_week = false)
		#Grabs array of all unique entries with a plant_id that matches the passed parent_id
		related_entry_ids = Entry.joins(:projections).uniq.where(rating:0,plant_id:parent_id).pluck(:id)
		# Totals all pots from projections where the entry_id is contained in the related_entry_ids array
		pots = Projection.where(entry_id:related_entry_ids, finish_week:finish_week).pluck(:pots).inject(:+)
		pots = Projection.where(entry_id:related_entry_ids, finish_week:finish_week).pluck(:pots).inject(:+) if finish_week
		pots.to_i
  end

  # Given a plant_id, returns all Projection pot totals for specified plant.  Can be isolated by finish_week.
  def self.projected_pots_by_plant(plant_id, finish_week = false)
  	if finish_week
  		pots = Projection.where(plant_id:plant_id, finish_week:finish_week).pluck(:pots).inject(:+)
  	else
  		pots = Projection.where(plant_id:plant_id).pluck(:pots).inject(:+)
  	end
  	pots.to_i
  end

  # Callback to set finish week based on parent plant with 22% added to time span.
  def set_finish_week
    week_array = (1..52).to_a
    finishtime = (self.parent.growth_cycle * 1.22).round()
    week_array.rotate!(week_array.index(finishtime + self.parent.stick_week.to_i))
    self.finish_week = week_array[0]
  end

  def set_delay_week
    self.delay_week = self.parent.grade_week
  end

  # Checks if a projection's parent entry is on its grade week or its delay week matches current.
  def ready?
    week_array = (1..52).to_a
    past_5_weeks_range = []
    week_array.rotate!(week_array.index(current_week))
    5.times do |week|
      past_5_weeks_range << week_array[0]
      week_array.rotate!(-1)
    end
    self.delay_week == current_week
  end

  # Iterates over all projections and returns all that are ready
  def self.ready
    ready = []
    Projection.all.each do |entry|
      ready << entry if entry.ready?
    end
    ready
  end

  private


end
