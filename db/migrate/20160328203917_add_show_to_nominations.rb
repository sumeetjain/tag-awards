class AddShowToNominations < ActiveRecord::Migration
  def change
    add_column :nominations, :show, :string
  end
end
