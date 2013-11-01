json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :name, :cuisine, :price, :delivery, :takeout, :reservations, :address, :latitude, :longitude
  json.url restaurant_url(restaurant, format: :json)
end
