class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def verify_admin
    if logged_in?
      redirect_to root_url  unless current_user.is_admin?
    else
      redirect_to admin_login_url
    end
  end
end
