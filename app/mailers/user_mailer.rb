class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: "Activation your account"
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: "Reset your password"
  end
end
