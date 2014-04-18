module PlantsHelper

	# Returns current week
	def current_week
		Time.now.strftime("%U").to_i + 1
	end

	 def weeks_before_now(number)
    @weeks_array = (1..52).to_a
    @weeks_array.rotate!(@weeks_array.index(current_week))
    @weeks_array.rotate!(number)
    @weeks_array[0]
  end

  def plant_array
    array = Plant.all.collect {|e| [ e.description, e.id ] }
    array.sort
  end

end
