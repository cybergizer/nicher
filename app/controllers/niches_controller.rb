class NichesController < ApplicationController
  include ApplicationConcern

  before_action :set_niche, only: %i[show edit update destroy]

  # GET /locations
  # GET /locations.json
  def index
    @niches = current_user.niches.reject(&:parent)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show; end

  # GET /locations/new
  def new
    @niche = current_user.niches.build
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations
  # POST /locations.json
  def create
    @niche = current_user.niches.new(processed_params)
    if @niche.save
      redirect_to @niche
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    if @niche.update(processed_params)
      redirect_to @niche
    else
      render :edit
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @niche.destroy
    redirect_to niches_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_niche
    @niche = set_resource
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def niche_params
    @niche_params ||= model_params(:niche)
  end

  def processed_params
    niche_params.merge(parent: parent)
  end

  def parent
    current_user.niches.find_by(id: niche_params.delete(:parent_id))
  end
end
