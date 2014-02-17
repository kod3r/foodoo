class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:new, :create]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @restaurants = @user.restaurants.includes(:locations, :lists)
    @hoods = @restaurants.joins(:locations).distinct.pluck(:hood, :city)
    @hoods.map! do |location|
      if location[0]
        location[0]
      else
        location[1]
      end
    end
    @hoods.uniq!.sort!
  end

  def list
  end

  def home
  end

  def address_input
    if params[:address] && params[:city] && params[:state]
      unless current_user.locations.where(address: params[:address], city: params[:city], state: params[:state]).exists?
        Location.create(locator_id: current_user.id, locator_type: "User", address: params[:address], city: params[:city], state: params[:state])
      end
    end
    render json: {}
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def getall
    @user = User.find(params[:id])
    @user.restaurants.each do |restaurant|
      unless current_user.restaurants.exists?(restaurant.id)
        List.create(user_id: current_user.id, restaurant_id: restaurant.id, label: "listed")
      end
    end

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username)
    end
end
