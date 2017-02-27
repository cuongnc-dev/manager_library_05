class User < ApplicationRecord
  has_many :active_follow_user, class_name:  FollowUser.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow_user, class_name:  FollowUser.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_follow_user, source: :followed
  has_many :followers, through: :passive_follow_user, source: :follower
  has_many :requests, dependent: :destroy
end
