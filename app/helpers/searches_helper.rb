module SearchesHelper

  def distance(restaurant)
    ((restaurant.locations.last.distance_to(session[:user_location])+0.1)*25).to_i
  end

  def solo_score(restaurant, user_id)
    if restaurant.lists.find_by(user_id: user_id)
      #check last visit
      if restaurant.choices.where(user_id: user_id).exists?
        if ((Time.now - restaurant.choices.where(user_id: user_id).last.created_at)/(24*60*60)).to_i > 5
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
      if distance(restaurant) < 10
        distance_score = 25
      else
        distance_score = 0
      end
      total_score = 25+time_score+fav_score+distance_score
      total_score
    else
      return 0
    end
  end

  def solo_ranker(user_id)
    ranked_list = User.find(user_id).restaurants.sort_by do |restaurant|
      solo_score(restaurant,user_id)
    end
    return ranked_list
  end

  def group_score(user_id_array, restaurant)
    total_score = 0
    user_id_array.each do |user_id|
      total_score+=solo_score(restaurant,user_id)
    end
    total_score/user_id_array.length
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
    return ranked_group_list
  end

end
