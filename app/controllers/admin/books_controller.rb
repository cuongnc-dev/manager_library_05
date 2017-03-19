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
    @books = Book.list_book_newest.paginate page: params[:page],
      per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    @book = Book.new book_params
    respond_to do |format|
      if @book.save
        flash[:success] = t "books.add_book_success"
        format.html {redirect_to admin_books_url}
      else
        format.html {render :new}
        format.js
      end
    end
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "books.update_success"
      redirect_to  admin_books_url
    else
      respond_to do |format|
        flash.now[:danger] = t "books.update_fail"
        format.js
      end
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
    flash[:warning] = t "book.book_not_found"
    redirect_to admin_books_url
  end

  def load_category
    @categories = Category.all
  end

  def load_author
    @authors = Author.all
  end

  def load_publisher
    @publishers = Publisher.all
  end

  def book_params
    params.require(:book).permit :title, :image, :description, :author_id,
      :category_id, :publisher_id, :current, :page_number
  end
end
