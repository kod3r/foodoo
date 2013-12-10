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
  json.top_cuisines
  if restaurant.choices.where(user_id: current_user.id).last
    json.last_choice restaurant.choices.where(user_id: current_user.id).last.created_at.to_date.strftime('%d %b %Y')
  else
    json.last_choice "New!"
  end
  json.distance ((restaurant.locations.last.distance_to(session[:user_location])+0.1)*25).to_i
end
