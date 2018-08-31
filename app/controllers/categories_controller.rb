class CategoriesController < ApplicationController
  include ApplicationConcern

  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories.roots
  end

  def show; end

  def new
    @category = current_user.categories.build
    @categories = current_user.categories
    render partial: 'categories/form'
  end

  def edit
    @categories = current_user.categories - [@category]
    render partial: 'categories/form'
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      render json: { status: 'ok' }
    else
      render json: { status: @category.errors.to_a.join('base') }
    end
  end

  def update
    if @category.update(category_params)
      render json: { status: 'ok' }
    else
      render json: { status: @category.errors.to_a.join('base') }
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  def move
    category = current_user.categories.find_by!(id: params[:id])
    parent = current_user.categories.find_by(id: params[:parent_id])
    category.parent = parent
    category.save
  end

  private

  def set_category
    @category = set_resource
  end

  def category_params
    model_params(:category)
  end
end
