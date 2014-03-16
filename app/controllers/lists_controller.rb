class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  def list
  end

  # GET /lists/new
  def new
    # yelp API query
    if params[:term]
      @yelp = HTTParty.get("http://api.yelp.com/business_review_search?"\
                        "term=#{params[:term].split(' ').join('+')}"\
                        "&location=#{params[:location].split(' ').join('+')}"\
                        "&category=restaurants"\
                        "&radius=20"\
                        "&limit=6"\
                        "&ywsid=Q5mQ5eJFseNNaJx9xuXhjQ")
      # collect results and populate db
      @results = []
      @yelp["businesses"].each do |place|
        unless place["is_closed"]
          refactored_address = place["address1"]+" "+place["zip"]
          address = place["address1"]
          restaurant_locations = Restaurant.where(name: place["name"]).joins(:locations)
          db_restaurant = restaurant_locations.where('locations.address' => refactored_address).first ||
                           restaurant_locations.where('locations.address' => address).first
          if db_restaurant
            restaurant = db_restaurant
          else
            categories = []
            place["categories"].each do |category|
              categories << category["name"]
            end
            categories = categories.join(', ')
            restaurant = Restaurant.create(name: place["name"], image: place["photo_url"], yelp_url: place["url"], cuisine: categories)
            if place["neighborhoods"][0]
              Location.create(locator_id: restaurant.id, locator_type: "Restaurant", city: place["city"], state: place["state"], country: place["country"], phone: place["phone"], address: address, hood: place["neighborhoods"][0]["name"])
            else
              Location.create(locator_id: restaurant.id, locator_type: "Restaurant", address: address, city: place["city"], state: place["state"], country: place["country"], phone: place["phone"])
            end
          end
          @results << restaurant
         end
      end
    end

    # check how many curated restaurants are on user's list
    @thrillist_count = current_user.restaurants.where(name: ["Minetta Tavern", "Whitman's", "Brindle Room", "Lure Fishbar", "Korzo Haus"]).count
    @thrillist_total = 5
    @zagat_count = current_user.restaurants.where(name: ["Lucali", "Luzzo's", "Paulie Gee's", "Di Fara Pizza", "Denino's Pizzeria Tavern", "Roberta's", "Franny's", "Motorino"]).count
    @zagat_total = 9
    @seriouseats_count = current_user.restaurants.where(name: ["Yuji Ramen", "Ramen Yebisu", "Jin Ramen", "Bassanova", "Totto Ramen", "Ippudo Ny", "Hide-Chan Ramen", "Chuko", "Ganso", "Tabata Noodle"]).count
    @seriouseats_total = 10

    #assign location to look for restaurants
    session[:search_location] = params[:location] if params[:location]
    unless current_user.locations.count == 0 || session[:search_location]
      session[:location_id] = session[:location_id] || current_user.locations.last.id
      user_location = Location.find(session[:location_id])
      session[:search_location] = user_location.city+' '+user_location.state
    end
  end

  def add_curated
    if params[:curated] == "thrillist-burger"
      @curated_list = Restaurant.where(name: ["Minetta Tavern", "Whitman's", "Brindle Room", "Lure Fishbar", "Korzo Haus"])
    elsif params[:curated] == "zagat-pizza"
      @curated_list = Restaurant.where(name: ["Lucali", "Luzzo's", "Paulie Gee's", "Di Fara Pizza", "Denino's Pizzeria Tavern", "Roberta's", "Franny's", "Motorino"])
    elsif params[:curated] == "seriouseats-ramen"
      @curated_list = Restaurant.where(name: ["Yuji Ramen", "Ramen Yebisu", "Jin Ramen", "Bassanova", "Totto Ramen", "Ippudo Ny", "Hide-Chan Ramen", "Chuko", "Ganso", "Tabata Noodle"])
    end
    if @curated_list
      @curated_list.each do |restaurant|
        unless current_user.restaurants.exists?(restaurant.id)
          List.create(user_id: current_user.id, restaurant_id: restaurant.id, label: "listed")
        end
      end
    end
    redirect_to :back
  end

  # GET /lists/1/edit
  def edit
  end

  def rate
    if params[:rating] && params[:list]
      List.find(params[:list]).update(rating: params[:rating])
    end
    render json: {}
  end

  # POST /lists
  # POST /lists.json
  def create
    if current_user.restaurants.where(id: params[:id]).empty?
      @list = List.new
      @list.user_id = current_user.id
      @list.label = "listed"
      @list.restaurant_id = params[:id]

      respond_to do |format|
        if @list.save
          format.html { redirect_to :back}
          format.json { render action: 'new', status: :created, location: @list }
        else
          format.html { render action: 'new' }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Already on your list!' }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:user_id, :restaurant_id, :label)
    end
end
