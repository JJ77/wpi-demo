class Plant < ActiveRecord::Base
	serialize :expiration
	serialize :finishtime
	has_many :child_plants, :class_name => "Plant", :foreign_key => "parent_plant_id"
	belongs_to :parent, :class_name => "Plant", :foreign_key => "parent_plant_id"
	has_many :entries, dependent: :destroy
	has_many :projections, dependent: :destroy
	# Returns current week
	def current_week
		Time.now.strftime("%U").to_i + 1
	end

	# Pass a query, returns the pots total
	def total_pots(query)
		query.pluck(:pots).inject(:+)
	end

	def inventory_percent
		total_pots = Entry.current.pluck(:pots).inject(:+)
		total_pots_of_self = Entry.current.where(plant_id:self.id).pluck(:pots).inject(:+)
		(total_pots_of_self.to_i / total_pots.to_i) * 100
	end

	# Polls all entries of self.plant, current and history
	def inventory
		Entry.where(plant_id:self.id)
	end
	# Returns current pots total
	def actual
		self.total_pots(self.current)
	end

	# Returns total pots of plant.current with given rating
	def rated(rating)
		total_pots(self.current.where(rating:rating)).to_i
	end

	# Polls are inventory where status is current.  Can specify a finish week.
	def current(finish_week = false)
		return self.inventory.where(status:0, finish_week:finish_week) if finish_week
		return self.inventory.where(status:0)
	end

	# Takes all current plant pots and removes any possible loss to projected plants (through grading)
	def projected(finish_week = false)
		total_current = self.current(finish_week).pluck(:pots).inject(:+).to_i
		total_projections = Projection.projected_pots_by_plant(self.id, finish_week)
		total_expected_loss_through_projections = Projection.projected_pots_by_parent(self.id, finish_week)
		(total_current + total_projections - total_expected_loss_through_projections) / self.ppprate
	end

end
