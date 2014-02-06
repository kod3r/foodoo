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
    session[:search_location] = params[:location] if params[:location]
    unless current_user.locations.count == 0 || session[:search_location]
      session[:location_id] = session[:location_id] || current_user.locations.last.id
      user_location = Location.find(session[:location_id])
      session[:search_location] = user_location.city+' '+user_location.state
    end
  end

  # GET /lists/1/edit
  def edit
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
          # format.js { render js: "$.gritter.add({text: '#{@list.restaurant.name} added', time: 2000, position: 'bottom-right'});" }
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
