json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :yelp_url, :image
  json.list_id List.where(user_id: current_user.id, restaurant_id: restaurant.id).take!.id
  json.score solo_score(restaurant, current_user.id)
  json.cuisines restaurant.cuisine.split(', ')
  if restaurant.lists.find_by(user_id: current_user.id).label == "favorite"
    json.label "favorite"
  else
    json.label nil
  end
  rating = restaurant.lists.find_by(user_id: current_user.id).rating
  if rating > 0
    json.rating rating
  else
    json.rating "new"
  end
  json.rating_number rating
  json.ll session[:location_ll]
  json.locations restaurant.locations.last, :hood, :city
  list_count = restaurant.lists.count
  json.lists list_count
  json.list_check true if list_count > 1
  # if restaurant.choices.where(user_id: current_user.id).last
  #   json.last_choice restaurant.choices.where(user_id: current_user.id).last.created_at.to_date.strftime('%d %b %Y')
  #   json.last_unix restaurant.choices.where(user_id: current_user.id).last.created_at
  # else
  #   json.last_choice "New!"
  #   json.last_unix "New!"
  # end
  miles = restaurant.locations.last.distance_to(session[:location_ll])
  json.miles miles.round(2)
  if miles < 1
    json.walk ((miles+0.1)*25).to_i
  else
    json.walk nil
  end
end
