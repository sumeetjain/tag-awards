class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :title
      t.integer :voter_id
      t.integer :nomination_item_id

      t.timestamps null: false
    end
  end
end
