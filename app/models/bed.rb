class Bed < ActiveRecord::Base
  before_save :set_location
  belongs_to :greenhouse
  belongs_to :location
  has_many :entries
  validates :name, presence: true, uniqueness:true


  	def current
  		Entry.where(status:0, bed_id:self.id)
  	end

  	def pots
  		self.current.pluck(:pots).inject(:+)
  	end

  	private

	  	def set_location
	  		self.location_id = Greenhouse.find(self.greenhouse_id).location_id
	  	end
end

