class RenameModelNominationsToLegacynominations < ActiveRecord::Migration
  def self.up
    rename_table :nominations, :legacy_nominations
  end

  def self.down
    rename_table :legacy_nominations, :nominations
  end
end
