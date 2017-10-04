class User < ApplicationRecord
  extend Auth
  has_many :viewings, dependent: :destroy
  attr_accessor :remember_token, :reset_token

  before_save { email.downcase! }
  validates :username,  presence: true, length: { maximum: 50 },
                        uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,     presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX }
  validates :full_name, presence: true, length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, :if => :password
  validates :admin, inclusion: { in: [true, false] }
  validates :membership_active, inclusion: { in: [true, false] }

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Updates a user's reset token and reset digest in the database
  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes(reset_digest: User.digest(reset_token),
                      reset_sent_at: Time.zone.now)
  end

  # Returns true if password reset sent more than 2 hours ago
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private


end
