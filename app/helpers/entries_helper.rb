module EntriesHelper

 def roll_bed_box(entry)
  select_tag(
    "entry_beds[#{entry.id}]",
    options_for_select(Bed.pluck(:name, :id),
    entry.parent.bed_id),
    :include_blank => true )
  end

  def roll_location_box(entry)
    select_tag(
      "entry_locations[#{entry.id}]",
      options_for_select(Location.pluck(:name, :id),
      entry.parent.location_id),
      :include_blank => true )
  end

  def roll_greenhouse_box(entry)
    select_tag(
      "entry_greenhouses[#{entry.id}]",
      options_for_select(Greenhouse.pluck(:name, :id),
      entry.parent.greenhouse_id),
      :include_blank => true )
  end

  def roll_pots_box(entry)
    ppprate = Plant.find(entry.plant_id).ppprate
    text_field_tag("entry_pots[#{entry.id}]", entry.pots/ppprate)
  end

    def plant_array
    array = Plant.all.collect {|e| [ e.description, e.id ] }
    array.sort
  end
end
