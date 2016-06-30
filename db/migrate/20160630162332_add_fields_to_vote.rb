class AddFieldsToVote < ActiveRecord::Migration
  def change
    add_reference :votes, :user, index: true, foreign_key: true
    add_reference :votes, :ballot_item, index: true, foreign_key: true
  end
end
