class User < ApplicationRecord
  before_save { email.downcase! }
  validates :username,  presence: true, length: { maximum: 50 },
                        uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,     presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX }
  validates :full_name, presence: true, length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  private


end
