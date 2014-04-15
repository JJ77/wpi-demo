json.array!(@beds) do |bed|
  json.extract! bed, :id, :name, :capacity, :greenhouse_id, :location_id
  json.url bed_url(bed, format: :json)
end
