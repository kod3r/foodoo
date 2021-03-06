module SearchesHelper
  def miles_or_min(restaurant)
    miles = restaurant.locations.last.distance_to(session[:location_ll]) || 2
    miles < 1 ? ((miles+0.1)*25).to_i.to_s+' min walk!' : miles.round(2).to_s+' miles'
  end
  def distance(restaurant)
    if restaurant.locations.last.distance_to(session[:location_ll])
      ((restaurant.locations.last.distance_to(session[:location_ll])+0.1)*25).to_i
    else
      50
    end
  end

  def solo_score(restaurant, user_id)
    list = restaurant.lists.find_by(user_id: user_id)
    if list
      #check last visit
      if restaurant.choices.where(user_id: user_id).exists?
        if ((Time.now - restaurant.choices.where(user_id: user_id).last.created_at)/(24*60*60)).to_i > User.find(user_id).restaurants.count/2
          time_score = 10
        else
          time_score = 0
        end
      else
        time_score = 10
      end
      #check favorite
      if list.label=="favorite"
        fav_score = 10
      else
        fav_score = 0
      end
      if (list.rating - 70) > 0
        rating_score = list.rating - 70
      elsif list.rating == 0
        rating_score = 10
      else
        rating_score = 0
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
      total_score = rating_score+time_score+fav_score+distance_score
      total_score
    else
      return 0
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
