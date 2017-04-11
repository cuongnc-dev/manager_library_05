class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :start_day, presence: true, date: {after_or_equal_to: Date.today}
  validates :end_day, presence: true, date: {after_or_equal_to: :start_day}

  delegate :email, to: :user, prefix: true
  delegate :id, :title, :current, :image, to: :book, prefix: true

  scope :list_request_newest, -> {order created_at: :desc}
  scope :list_request_by_user, -> id do
    joins(:user).select("requests.*").where "users.id = ?", "#{id}"
  end
  scope :search_request_by_user, -> name do
    joins(:user).select("requests.*").where "users.name like ?", "%#{name}%"
  end
  scope :search_request_by_book, -> title do
    joins(:book).select("requests.*").where "books.title like ?", "%#{title}%"
  end
  scope :search_by_absolute_start_day, -> start_day {where start_day: start_day}
  scope :search_by_relative_start_day, -> from, to do
    where "start_day between ? and ?", "#{from}", "#{to}"
  end
  scope :search_by_absolute_end_day, -> end_day {where end_day: end_day}
  scope :search_by_relative_end_day, -> from, to do
    where "end_day between ? and ?", "#{from}", "#{to}"
  end
  scope :search_by_start_end_day, -> start_day, end_day do
    where "start_day >= ? and end_day <= ?", "#{start_day}", "#{end_day}"
  end
  scope :search_request_by_status, -> status {where status: status}
  scope :search_request_by_user_end_day, -> user_id do
    where "user_id = ? and end_day = ?", "#{user_id}", Date.today
  end
end
