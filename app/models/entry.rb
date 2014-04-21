class Entry < ActiveRecord::Base
  has_many :projections, dependent: :destroy
  belongs_to :plant
  belongs_to :bed
  belongs_to :greenhouse
  belongs_to :location
  before_save :set_greenhouse, :set_location
  before_create :set_status




  def current_week
      # Returns an integer representation of current week in year
      Time.now.strftime("%U").to_i + 1
  end

  def ==(entry)
    return false unless self.stick_week == entry.stick_week
    return false unless self.pots == entry.pots
    return false unless self.plant_id == entry.plant_id
    return false unless self.rating == entry.rating
    true
  end

  def grade_week
      # Uses week_array to find difference between stick_week and finish_week
      # Then takes 0.667 of that difference and returns the grade week based
      # on that number.  Grade week occurs 2/3rds into growth cycle.
      if Plant.find(self.plant_id).has_children?
        weeks_array = (1..52).to_a
        weeks_array.rotate!(weeks_array.index((self.stick_week + (self.growth_cycle * 0.6667)).round))
        weeks_array[0]
      else
        "0"
      end
    end

    def growth_cycle
      weeks_array = (1..52).to_a
      weeks_array.rotate!(weeks_array.index(self.stick_week))
      growth_cycle = weeks_array.index(self.finish_week)
    end

    def set_finish_week
      week_array = (1..52).to_a
      finishtime = Plant.find(self.plant_id).finishtime[self.stick_week]
      week_array.rotate!(week_array.index(self.stick_week) + finishtime.to_i)
      self.finish_week = week_array[0]
    end

  private
    # Callback to set greenhouse before save based strictly on zone
  	def set_greenhouse
  		self.greenhouse_id = Bed.find(self.bed_id).greenhouse_id
  	end

    # Counts total weeks between a entry's stick_week and finish_week


    # Callback to set location before save based strictly on zone
  	def set_location
  		self.location_id = Greenhouse.find(Bed.find(self.bed_id).greenhouse_id).location_id
  	end

    # Callback to set finish_week before create


    def rating_to_finish_week_conversion
      week_array = (1..52).to_a
      if self.rating = 5
        week_array.rotate!(week_array.index(self.current_week + 1))
      elsif self.rating = 6
        week_array.rotate!(week_array.index(self.current_week))
      end
      self.finish_week = week_array[0]
    end

    # Callback to set status before create
    def set_status
      self.status = 0
    end

    # Relation of all entries with 0 status (current)
    def self.current
      self.where(status:0)
    end

    # Relation of all entries with 1 status (history)
    def self.history
      Self.where(status:1)
    end
end
