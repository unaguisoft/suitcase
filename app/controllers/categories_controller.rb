class CategoriesController < ApplicationController

  before_action :only_authorize_admin!, except: [:index]
  before_action :set_category, only: [:edit, :update, :destroy, :upload_category_photos]

  def index
    @categories = Category.all.page(params[:page]).decorate
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to :categories, notice: "Category was updated."
    else
      flash[:error] = 'Oops, there was an error trying to update the category.'
    end
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to upload_category_photos_category_path(@category), 
        notice: 'Category was created. Please, select an image' 
    else
      flash[:error] = "Oops, there was an error trying to create the category."
      render :new
    end
  end

  def destroy
    if @category.destroy
      redirect_to :categories, notice: "Category was deleted."
    else
      flash[:error] = "Oops, there was an error trying to delete the category."
      redirect_to :categories
    end
  end

  def upload_category_photo
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "The category doesn't exists"
      redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :dimensions, :weight, :stock, :insurance_percent) if params[:category].present?
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
