class Admin::UsersController < ApplicationController
  before_action :verify_admin
  before_action :load_user, only: [:edit, :destroy, :update]
  skip_before_filter :verify_authenticity_token, only: [:create, :update]

  layout "admin"

  def new
    @user = User.new
  end

  def index
    @users = User.list_newest.paginate page: params[:page],
      per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "users.add_user_success"
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.update_success"
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "users.user_not_found"
    redirect_to admin_users_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :phone, :is_admin, :activated, :address, :avatar
  end
end
