json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :yelp_url, :image
  json.list_id List.where(user_id: current_user.id, restaurant_id: restaurant.id).take!.id
  json.cuisines restaurant.cuisine.split(', ')
  if restaurant.lists.find_by(user_id: current_user.id).label == "favorite"
    json.label "favorite"
    fav_score = 20
  else
    json.label nil
    fav_score = 0
  end
  rating = restaurant.lists.find_by(user_id: current_user.id).rating
  if rating >= 70
    json.rating rating
    rating_score = ((rating-70)*4)/3
  elsif rating == 0
    json.rating "new"
    rating_score = 10
  else
    json.rating rating
    rating_score = 0
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
  miles = restaurant.locations.last.distance_to(session[:location_ll]) || 2
  json.miles miles.round(2)
  if miles < 0.25
    json.walk ((miles+0.1)*25).to_i
    distance_score = 40
  elsif miles < 0.50
    json.walk ((miles+0.1)*25).to_i
    distance_score = 30
  elsif miles < 0.75
    json.walk ((miles+0.1)*25).to_i
    distance_score = 20
  elsif miles < 1.00
    json.walk ((miles+0.1)*25).to_i
    distance_score = 10
  else
    json.walk nil
    distance_score = 0
  end
  total_score = distance_score + rating_score + fav_score
  json.score total_score
end
