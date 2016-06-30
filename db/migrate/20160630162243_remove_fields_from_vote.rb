class RemoveFieldsFromVote < ActiveRecord::Migration
  def change
    remove_column :votes, :title, :string
    remove_column :votes, :voter_id, :integer
    remove_column :votes, :nomination_item_id, :integer
  end
end
