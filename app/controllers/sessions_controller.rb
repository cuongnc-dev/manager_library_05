class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
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

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
