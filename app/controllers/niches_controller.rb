class NichesController < ApplicationController
  include ApplicationConcern

  before_action :set_niche, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: %i[move]

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
    render partial: 'niches/form'
  end

  # GET /locations/1/edit
  def edit
    render partial: 'niches/form'
  end

  # POST /locations
  # POST /locations.json
  def create
    @niche = current_user.niches.new(processed_params)
    if @niche.save
      render json: { status: 'ok' }
    else
      render json: { status: 'error' }
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    if @niche.update(processed_params)
      render json: { status: 'ok' }
    else
      render json: { status: 'error' }
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @niche.destroy
    redirect_to niches_url
  end

  def move
    p JSON.parse(params[:tree])[0]
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
