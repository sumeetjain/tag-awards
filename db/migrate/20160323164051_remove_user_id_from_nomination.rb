class RemoveUserIdFromNomination < ActiveRecord::Migration
  def change
    remove_column :nominations, :user_id, :integer
    add_reference :nominations, :user, index: true
  end
end
