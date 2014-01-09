json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :yelp_url, :image
  json.score solo_score(restaurant, current_user.id)
  json.cuisines restaurant.cuisine.split(', ')
  if restaurant.lists.find_by(user_id: current_user.id).label == "favorite"
    json.label "favorite"
  else
    json.label nil
  end
  json.url restaurant_url(restaurant, format: :json)
  json.locations restaurant.locations.last, :hood, :city
  json.lists restaurant.lists.count
  json.list_check true if restaurant.lists.count > 1
  json.top_cuisines
  if restaurant.choices.where(user_id: current_user.id).last
    json.last_choice restaurant.choices.where(user_id: current_user.id).last.created_at.to_date.strftime('%d %b %Y')
    json.last_unix restaurant.choices.where(user_id: current_user.id).last.created_at
  else
    json.last_choice "New!"
    json.last_unix "New!"
  end
  if restaurant.locations.last.distance_to(session[:user_location])
    json.distance ((restaurant.locations.last.distance_to(session[:user_location])+0.1)*25).to_i
  else
    json.distance 50
  end
end
