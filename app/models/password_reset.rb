# Contains User methods related to password reset_token
module PasswordReset
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

end
