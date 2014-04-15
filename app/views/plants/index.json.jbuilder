json.array!(@plants) do |plant|
  json.extract! plant, :id, :item_code, :description, :finishtime, :expiration, :parent_plant_id
  json.url plant_url(plant, format: :json)
end
