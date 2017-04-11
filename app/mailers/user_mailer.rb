class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("activation_account")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("reset_password")
  end

  def book_notification user, book
    @book = book
    @user = user
    mail to: user.email,
      subject: t("author_new_book") + " " + book.author_name
  end

  def comment_notification current_user, user, comment
    @current_user = current_user
    @user = user
    @comment = comment
    mail to: user.email,
      subject: t("new_comment") + " " + comment.book_title
  end

  def duo_borrow_book user, request
    @user = user
    @request = request
    mail to: user.email, subject: t("end_time_notification")
  end
end
