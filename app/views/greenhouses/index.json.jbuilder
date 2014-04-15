json.array!(@greenhouses) do |greenhouse|
  json.extract! greenhouse, :id, :name, :description, :location_id
  json.url greenhouse_url(greenhouse, format: :json)
end
