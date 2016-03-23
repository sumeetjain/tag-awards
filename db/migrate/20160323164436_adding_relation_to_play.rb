class AddingRelationToPlay < ActiveRecord::Migration
  def change
    remove_column :plays, :theater_id
    add_reference :plays, :theater, index: true
  end
end
