class RemovePlayIdFromNominations < ActiveRecord::Migration
  def change
    remove_column :nominations, :play_id, :integer
  end
end
