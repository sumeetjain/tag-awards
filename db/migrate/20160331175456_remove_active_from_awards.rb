class RemoveActiveFromAwards < ActiveRecord::Migration
  def change
    remove_column :awards, :active, :boolean
  end
end
