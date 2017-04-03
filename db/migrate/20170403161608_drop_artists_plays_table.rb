class DropArtistsPlaysTable < ActiveRecord::Migration
  def up
    drop_table :artists_plays
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
