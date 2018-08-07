class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = current_user.locations.where(parent_id: nil)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show; end

  # GET /locations/new
  def new
    @location = current_user.locations.create
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations
  # POST /locations.json
  def create
    @location = current_user.locations.create(location_params)

    if @location.save
      redirect_to @location
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    if @location.update(location_params)
      redirect_to @location
    else
      render :edit
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    redirect_to locations_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:name, :parent_id)
  end
end
