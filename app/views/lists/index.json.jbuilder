json.array!(@lists) do |list|
  json.extract! list, :user_id, :restaurant_id, :label
  json.url list_url(list, format: :json)
end
