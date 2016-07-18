class CreateVotingPeriods < ActiveRecord::Migration
  def change
    create_table :voting_periods do |t|
      t.integer :year
      t.string :ballot_status

      t.timestamps null: false
    end
  end
end
