class Admin::AdminsController < ApplicationController
  before_action :verify_admin, only: [:home, :login]

  layout "admin"

  def home
  end

  def login
  end

  private

  def verify_admin
    if logged_in?
      if is_administrator?
        render :home
      else
        redirect_to root_url
      end
    else
      render :login
    end
  end
end
