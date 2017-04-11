class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true, length: {minimum: Settings.min_comment}

  def notification_new_comment(current_user, users, comment)
    users.each do |user|
      UserMailer.comment_notification(current_user, user, comment).deliver
    end
  end

  delegate :avatar, :name, to: :user, prefix: true
  delegate :title, to: :book, prefix: true

  scope :list_newest_comment, -> {order created_at: :desc}
end
