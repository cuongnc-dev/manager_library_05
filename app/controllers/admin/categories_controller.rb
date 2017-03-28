class Admin::CategoriesController < ApplicationController
  before_action :verify_admin
  before_action :load_category, only: [:edit, :destroy, :update]

  layout "admin"

  def new
    @category = Category.new
  end

  def index
    @categories = Category.list_newest_category.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "categories.add_category_success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "categories.update_success"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "categories.delete_success"
    else
      flash[:danger] = t "categories.delete_fail"
    end
    redirect_to admin_categories_url
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:warning] = t "categories.category_not_found"
    redirect_to admin_categories_url
  end

  def category_params
    params.require(:category).permit :name
  end
end
