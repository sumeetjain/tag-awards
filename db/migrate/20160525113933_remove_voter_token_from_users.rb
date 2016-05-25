class RemoveVoterTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :voter_token, :string
  end
end