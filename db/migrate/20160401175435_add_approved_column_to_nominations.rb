class AddApprovedColumnToNominations < ActiveRecord::Migration
  def change
    add_column :nominations, :approved, :boolean
  end
end
