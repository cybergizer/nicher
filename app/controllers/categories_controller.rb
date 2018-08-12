class CategoriesController < ApplicationController
  include ApplicationConcern

  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories.roots
  end

  def show; end

  def new
    @category = current_user.categories.create
  end

  def edit; end

  def create
    @category = current_user.categories.create(category_params)

    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

  private

  def set_category
    @category = set_resource
  end

  def category_params
    model_params(:category)
  end
end
