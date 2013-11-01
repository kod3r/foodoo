json.array!(@choices) do |choice|
  json.extract! choice, :user_id, :search_id, :restaurant_id, :action
  json.url choice_url(choice, format: :json)
end
