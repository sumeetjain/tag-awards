class AddReferencesToBallotItems < ActiveRecord::Migration
  def change
    add_reference :ballot_items, :award, index: true, foreign_key: true
    add_reference :ballot_items, :play, index: true, foreign_key: true
  end
end
