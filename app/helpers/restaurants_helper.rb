module RestaurantsHelper
  def distance(restaurant)
    unless session[:location_ll]
      session[:location_id] = current_user.locations.last.id
      location = Location.find(session[:location_id])
      session[:location_ll] = [location.latitude, location.longitude]
    end
    ((restaurant.locations.last.distance_to(session[:location_ll])+0.1)*25).to_i
  end

  def solo_score(restaurant_id, user_id)
    restaurant = Restaurant.find(restaurant_id)
    if restaurant.lists.find_by(user_id: user_id)
      #check last visit
      if restaurant.choices.where(user_id: user_id).exists?
        if ((Time.now - restaurant.choices.where(user_id: user_id).last.created_at)/(24*60*60)).to_i > User.find(user_id).restaurants.count/2
          time_score = 25
        else
          time_score = 0
        end
      else
        time_score = 25
      end
      #check favorite
      if restaurant.lists.find_by(user_id: user_id).label=="favorite"
        fav_score = 25
      else
        fav_score = 0
      end
      #distance
      if distance(restaurant) < 5
        distance_score = 50
      elsif distance(restaurant) < 10
        distance_score = 40
      elsif distance(restaurant) < 20
        distance_score = 30
      elsif distance(restaurant) < 30
        distance_score = 20
      elsif distance(restaurant) < 40
        distance_score = 10
      else
        distance_score = 0
      end
      total_score = time_score+fav_score+distance_score
      total_score
    else
      return 0
    end
  end

  def solo_ranker(user_id)
    ranked_list = User.find(user_id).restaurants.sort_by do |restaurant|
      solo_score(restaurant,user_id)
    end
    if ranked_list.length > 10
      return ranked_list.reverse[0..9]
    else
      return ranked_list.reverse
    end
  end

  def group_score(user_id_array, restaurant)
    total_score = 0
    user_id_array.each do |user_id|
      total_score+=solo_score(restaurant,user_id)
    end
    total_score
  end

  def group_ranker(ppl)
    user_id_array = ppl.split(',')
    restaurant_array = []
    user_id_array.each do |user_id|
      restaurant_array+=User.find(user_id).restaurants
    end
    restaurant_array.uniq!
    ranked_group_list = restaurant_array.sort_by do |restaurant|
      group_score(user_id_array, restaurant)
    end
    if ranked_group_list.length > 100
      return ranked_group_list.reverse[0..99]
    else
      return ranked_group_list.reverse
    end
  end
end
