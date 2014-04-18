class Greenhouse < ActiveRecord::Base
  belongs_to :location
  has_many :beds, dependent: :destroy

  # Array of all beds in greenhouse
  def beds
  	Bed.where(greenhouse_id:self.id)
  end

  #All entries for specific greenhouse that are history
  def history
  	Entry.where(status:1, greenhouse_id:self.id)
  end

  #All entries for specific greenhouse that are current
  def current
  	Entry.where(status:0, greenhouse_id:self.id)
  end

  # Total plants in greenhouse
  def total
  	self.current.pluck(:pots).inject(:+)
  end

  def capacity
  	array = self.beds.pluck(:capacity)
    array.inject(0) {|result, element| result += element.to_i }
  end
end
