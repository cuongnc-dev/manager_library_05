class Admin::PublishersController < ApplicationController
  before_action :verify_admin
  before_action :load_publisher, only: [:edit, :destroy, :update]
  skip_before_filter :verify_authenticity_token, only: [:create, :update]

  layout "admin"

  def new
    @publisher = Publisher.new
  end

  def index
    @publishers = Publisher.list_newest_publisher.paginate page: params[:page],
      per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t "publishers.add_publisher_success"
      redirect_to admin_publishers_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t "publishers.update_success"
      redirect_to admin_publishers_url
    else
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t "publishers.delete_success"
    else
      flash[:danger] = t "publishers.delete_fail"
    end
    redirect_to admin_publishers_url
  end

  private

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
    flash[:warning] = t "publishers.publisher_not_found"
    redirect_to admin_publishers_url
  end

  def publisher_params
    params.require(:publisher).permit :name, :email, :phone, :address, :image
  end
end
