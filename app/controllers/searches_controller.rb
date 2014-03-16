class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end


  def distance(restaurant)
    restaurant.locations.last.distance_to(session[:location_ll]) || 2
  end

  def solo_score(restaurant, user_id)
    list = restaurant.lists.find_by(user_id: user_id)
    if list
      #hit list component
      case list.label
        when 'favorite'  then fav_score = 20
        else                  fav_score = 0
      end
      #rating component
      case list.rating
        when 70..100     then rating_score = ((list.rating-70)*4)/3
        when 0           then rating_score = 10
        else                  rating_score = 0
      end
      rating_score+fav_score
    else
      0
    end
  end

  def group_score(restaurant, people)
    total_score = 0
    person_count = people.count
    people.each do |person|
      total_score+=solo_score(restaurant, person.id)
    end
    case distance(restaurant)
      when 0...0.25    then distance_score = 40*person_count
      when 0.25...0.50 then distance_score = 30*person_count
      when 0.50...0.75 then distance_score = 20*person_count
      when 0.75...1    then distance_score = 10*person_count
      else                  distance_score = 0
    end
    total_score+distance_score
  end

  def group_ranker
    restaurant_array = []
    group_names = session[:buddies] << current_user.username
    people = User.where(username: group_names)
    # nearby_restaurants = Location.where(locator_type: "Restaurant").near(session[:location_ll], 1)
    people.each do |person|
      # restaurant_array+=person.restaurants.joins(:locations).merge(nearby_restaurants)
      restaurant_array+=person.restaurants
    end
    restaurant_array.uniq!

    ranked_group_list = restaurant_array.sort_by do |restaurant|
      group_score(restaurant, people)
    end
    case ranked_group_list.length
      when 0...3 then ranked_group_list.reverse
      else            ranked_group_list.reverse[0...3]
    end
  end

  def set_user_location
    if params[:lat] && params[:lon]
      session[:user_location] = [params[:lat], params[:lon]]
      session[:acc] = params[:acc].to_i
    end
    render json: {}
  end
  # GET /searches/new
  def new
    @buddies = User.where.not(id: current_user.id)
    @buddies.sort_by! do |buddy|
      buddy.restaurants.count
    end
    @buddies.reverse!

    session[:buddies] = session[:buddies] || []
    if request.post?
      session[:buddies] = params[:buddies]
    end

    @picks = group_ranker

    if current_user.locations.count > 0
      if current_user.locations.last.created_at > (Time.now - 10)
        session[:location_id] = current_user.locations.last.id
      else
        session[:location_id] = session[:location_id] || current_user.locations.last.id
      end
      location = Location.find(session[:location_id])
      session[:location_ll] = [location.latitude, location.longitude]
    end
    gon.locationId = session[:location_id]
    gon.buddies = session[:buddies]
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render action: 'show', status: :created, location: @search }
      else
        format.html { render action: 'new' }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:user_id, :method_filter, :cuisine_filter, :price_filter, :members, :time, :date, :ip_address, :latitude, :longitude)
    end
end
