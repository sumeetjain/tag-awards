class RemoveAwardIdFromNomination < ActiveRecord::Migration
  def change
    remove_column :nominations, :award_id, :integer
    remove_column :nominations, :theater_id, :integer
    remove_column :nominations, :play_id, :integer

    add_reference :nominations, :award, index: true
    add_reference :nominations, :play, index: true
    
  end
end
