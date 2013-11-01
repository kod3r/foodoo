json.array!(@searches) do |search|
  json.extract! search, :user_id, :method_filter, :cuisine_filter, :price_filter, :members, :time, :date, :ip_address, :latitude, :longitude
  json.url search_url(search, format: :json)
end
