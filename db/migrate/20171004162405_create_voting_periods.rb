class CreateVotingPeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :voting_periods do |t|
      t.integer :year, null: false
      t.boolean :active, default: false, null: false

      t.timestamps
    end
    add_index :voting_periods, :year, unique: true
  end
end
