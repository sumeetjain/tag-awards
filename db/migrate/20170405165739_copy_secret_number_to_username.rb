class CopySecretNumberToUsername < ActiveRecord::Migration
  def self.up
    User.update_all("secret_number=username")
  end
end
