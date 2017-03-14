class UsersController < ApplicationController

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        @user.send_activation_email
        flash.now[:info] = t "check_email"
        format.html {render :new}
        format.js
      else
        format.html {render :new}
        format.js
      end
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
