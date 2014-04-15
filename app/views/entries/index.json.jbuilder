json.array!(@entries) do |entry|
  json.extract! entry, :id, :pots, :stick_week, :hang_week, :finish_week, :rating, :status, :plant_id, :bed_id, :greenhouse_id, :location_id
  json.url entry_url(entry, format: :json)
end
