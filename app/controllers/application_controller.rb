class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def verify_admin
    if logged_in?
      redirect_to root_url  unless current_user.is_admin?
    else
      redirect_to admin_login_url
    end
  end

  def load_menu
    @authors = Author.list_author_order_name
    @categories = Category.list_category_order_name
    @publishers = Publisher.list_publisher_order_name
    if params[:menu_level] == Settings.char_one
      @subcategories = Subcategory.
        list_subcategory_by_category(params[:sub_id]).
          list_subcategory_order_name
      render json: @subcategories
    end
  end
end
