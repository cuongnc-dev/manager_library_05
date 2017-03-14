class User < ApplicationRecord
  has_many :active_follow_user, class_name: FollowUser.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow_user, class_name: FollowUser.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_follow_user, source: :followed
  has_many :followers, through: :passive_follow_user, source: :follower
  has_many :requests, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: {maximum: Settings.max_name_user}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.max_name_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.min_passwd}, allow_nil: true

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver
  end

  def activation_email_expired?
    activation_sent_at < 24.hours.ago
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 1.hours.ago
  end

  def update_activation_digest
    self.activation_token = User.new_token
    update_attribute(:activation_digest, User.digest(activation_token))
    update_attribute(:activation_sent_at, Time.zone.now)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
    self.activation_sent_at = Time.zone.now
  end
end
