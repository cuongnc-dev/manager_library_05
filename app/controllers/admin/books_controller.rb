class Admin::BooksController < ApplicationController
  before_action :verify_admin
  before_action :load_book, only: [:edit, :destroy, :update]
  before_action :load_author, exept: [:show, :destroy]
  before_action :load_category, exept: [:show, :destroy]
  before_action :load_publisher, exept: [:show, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:create, :update]

  layout "admin"

  def new
    @book = Book.new
  end

  def index
    case
    when params[:key]
      case
      when params[:find_by] == Book.name
        @books = Book.search_book_by_title(params[:key]).list_book_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Author.name
        @books = Book.search_book_by_author(params[:key]).list_book_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Subcategory.name
        @books = Book.search_book_by_subcategory(params[:key]).
          list_book_newest.paginate page: params[:page], per_page: Settings.per_page
      else
        @books = Book.search_book_by_publisher(params[:key]).
          list_book_newest.paginate page: params[:page], per_page: Settings.per_page
      end
    else
      @books = Book.list_book_newest.paginate page: params[:page],
        per_page: Settings.per_page
    end
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    @book = Book.new book_params
    if @book.save
      @users_follow = User.list_users_follow_author @book.author_id
      @book.send_notification_email(@users_follow, @book) if @users_follow.present?
      flash[:success] = t "books.add_book_success"
      redirect_to admin_books_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "books.update_success"
      redirect_to admin_books_url
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "books.delete_success"
    else
      flash[:danger] = t "books.delete_fail"
    end
    redirect_to admin_books_url
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:warning] = t "books.book_not_found"
    redirect_to admin_books_url
  end

  def load_category
    @categories = Subcategory.list_subcategory_order_name
  end

  def load_author
    @authors = Author.list_author_order_name
  end

  def load_publisher
    @publishers = Publisher.list_publisher_order_name
  end

  def book_params
    params.require(:book).permit :title, :image, :description, :author_id,
      :subcategory_id, :publisher_id, :current, :page_number
  end
end
