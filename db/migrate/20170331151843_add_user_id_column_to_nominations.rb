class AddUserIdColumnToNominations < ActiveRecord::Migration
  def change
    add_column :nominations, :user_id, :integer
  end
end
