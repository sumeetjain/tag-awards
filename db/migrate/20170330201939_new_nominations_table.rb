class NewNominationsTable < ActiveRecord::Migration
  def self.up
    create_table :nominations do |t|
      t.integer :potential_nomination_id
    end
  end

  def self.down
    remove_table :nominations
  end
end
