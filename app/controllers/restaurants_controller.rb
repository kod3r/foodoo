class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  # before_action :set_location


  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = current_user.restaurants.includes(:locations, :lists)
    unless current_user.restaurants.count == 0
      if current_user.locations.last.created_at > (Time.now - 10)
        session[:location_id] = current_user.locations.last.id
      else
        session[:location_id] = session[:location_id] || current_user.locations.last.id
      end
      location = Location.find(session[:location_id])
      session[:location_ll] = [location.latitude, location.longitude]
    end
  end

  def address_input
    session[:location_id] = params[:location_id]
    redirect_to :back
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    Choice.create(user_id: current_user.id, restaurant_id: params[:id], action: "yes")
    ordrin_api = Ordrin::APIs.new("hgdPJATkdYDnr7JFSLA0BllmiS4v55h_s46K2hwacQU", :test)
    # args = {"datetime" => "ASAP", "addr" => "160 Pearl Street", "city" => "New York City", "zip" => "10005"}
    # list = ordrin_api.delivery_list(args)
    # d_check = list.find_index{|restaurant| restaurant["na"]==@restaurant.name}
    # if d_check.is_a? Integer
    #   @rid = list[d_check]["id"].to_s
    # end
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  def remove
    List.find(params[:id]).destroy
    redirect_to :back
  end

  def favorite
    @fav_toggle = List.find(params[:id])
    if @fav_toggle.label == "favorite"
      @fav_toggle.update(label: "listed")
    else
      @fav_toggle.update(label: "favorite")
    end
    redirect_to :back
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.lists.find_by(user_id: current_user.id).update(label: "listed")
    redirect_to :back, notice: "Un-favorited "+@restaurant.name
  end
  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @restaurant }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant successfully deleted" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :cuisine, :price, :delivery, :takeout, :reservations, :address, :latitude, :longitude)
    end
end
