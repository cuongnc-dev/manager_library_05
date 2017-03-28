class PasswordResetsController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    respond_to do |format|
      if @user
        @user.create_reset_digest
        @user.send_password_reset_email
        flash.now[:info] = t "pw_reset_info"
        format.js
      else
        flash.now[:danger] = t "pw_reset_danger"
        format.js
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      case
      when (params[:user][:password].empty? ||
        params[:user][:password_confirmation].empty? ||
        params[:user][:password].length < Settings.min_passwd ||
        params[:user][:password] != params[:user][:password_confirmation])
        case
        when params[:user][:password].empty?
          @user.errors.add(:password,
            t("activerecord.errors.models.user.attributes.password.blank"))
        when params[:user][:password].length < Settings.min_passwd
          @user.errors.add(:password,
            t("activerecord.errors.models.user.attributes.password.too_short"))
        when params[:user][:password_confirmation].empty?
          @user.errors.add(:password_confirmation,
            t("activerecord.errors.models.user.attributes.password_confirmation.blank"))
        else
          @user.errors.add(:password_confirmation,
            t("activerecord.errors.models.user.attributes.password_confirmation.confirmation"))
        end
        format.html {render :edit}
        format.js
      when @user.update_attributes(user_params)
        log_in @user
        @user.update_attribute(:reset_digest, nil)
        flash.now[:success] = t "pw_reset_success"
        format.js
      else
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    unless @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash.now[:danger] = t "pw_reset_expired"
    end
  end
end
