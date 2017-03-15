class AccountActivationsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:email]
    respond_to do |format|
      user.update_activation_digest
      user.send_activation_email
      flash.now[:info] = t "check_email"
      format.js
    end
  end

  def edit
    user = User.find_by email: params[:email]
    if (user && !user.activated? && user.authenticated?(:activation, params[:id]) &&
      user.activation_email_expired?)
      user.update_activation_digest
      user.send_activation_email
      mess = t("activation_expired") + " "
      mess += t("new_email_activation") + " " + t("check_email")
      flash.now[:danger] = mess
    elsif user && !user.activated? && user.authenticated?(:activation, params[:id]
      user.activate
      log_in user
      message = t("welcome") + " "
      message += user.name + ", " + t("account_activated")
      flash.now[:success] = message
    else
      flash.now[:danger] = t "invalid_activation"
    end
  end
end
