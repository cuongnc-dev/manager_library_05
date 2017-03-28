class SessionsController < ApplicationController
  before_action :load_user, only: [:create, :create_admin]

  def new
  end

  def create
    respond_to do |format|
      if @user && @user.authenticate(params[:session][:password])
        if @user.activated?
          log_in @user
          params[:session][:remember_me] == Settings.remember_me ? remember(@user) : forget(@user)
          format.html {redirect_to root_url}
        else
          @user.errors[:base] << t("account_not_activated")
          mess = t "account_not_activated"
          mess += " " + t("resend_activate_account")
          flash.now[:warning] = mess
          format.js
        end
      else
        flash.now[:danger] = t "invalid_login"
        format.js
      end
    end
  end

  def create_admin
    if @user && @user.authenticate(params[:session][:password])
      if @user.is_admin?
        log_in @user
        params[:session][:remember_me] == Settings.remember_me ? remember(@user) : forget(@user)
        redirect_to admin_root_url
      else
        flash[:warning] = t "not_admin"
        redirect_to admin_login_url
      end
    else
      flash[:danger] = t "invalid_login"
      redirect_to admin_login_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def destroy_admin
    log_out if logged_in?
    redirect_to admin_root_url
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
  end
end
