class Admin::AdminController < ApplicationController
  before_action :check_admin, only: :new
  before_action :verify_admin, only: :index

  layout "admin"

  def new
  end

  def index
    case
    when params[:find_by] == User.name
      @users = User.search_user_by_name(params[:key_word]).list_newest.
        paginate page: params[:page], per_page: Settings.per_page
    when params[:find_by] == Book.name
      @books = Book.search_book_by_title(params[:key_word]).list_newest.
        paginate page: params[:page], per_page: Settings.per_page
    when params[:find_by] == Author.name
      @authors = Author.search_author_by_name(params[:key_word]).list_newest.
        paginate page: params[:page], per_page: Settings.per_page
    when params[:find_by] == Category.name
      @categories = Category.search_category_by_name(params[:key_word]).
        list_newest.paginate page: params[:page], per_page: Settings.per_page
    when params[:find_by] == Publisher.name
      @publishers = Publisher.search_publisher_by_name(params[:key_word]).
        list_newest.paginate page: params[:page], per_page: Settings.per_page
    else
      redirect_to admin_root_url
    end
  end

  private

  def check_admin
    if logged_in?
      if is_administrator?
        redirect_to admin_root_url
      else
        redirect_to root_url
      end
    else
      render :new
    end
  end
end
