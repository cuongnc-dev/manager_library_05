class Admin::AuthorsController < ApplicationController
  before_action :verify_admin
  before_action :load_author, only: [:edit, :destroy, :update]
  before_action :load_publisher, exept: [:show, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:create, :update]

  layout "admin"

  def new
    @author = Author.new
  end

  def index
    respond_to do |format|
      @authors = Author.list_newest.paginate page: params[:page],
        per_page: Settings.per_page
      format.html
      format.xlsx
    end
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t "authors.add_author_success"
      redirect_to admin_authors_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @author.update_attributes author_params
      flash[:success] = t "authors.update_success"
      redirect_to admin_authors_url
    else
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t "authors.delete_success"
    else
      flash[:danger] = t "authors.delete_fail"
    end
    redirect_to admin_authors_url
  end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:warning] = t "authors.author_not_found"
    redirect_to admin_authors_url
  end

  def load_publisher
    @publishers = Publisher.all
  end

  def author_params
    params.require(:author).permit :name, :email, :phone, :address, :avatar,
      :publisher_id
  end
end
