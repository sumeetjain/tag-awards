class AddInactiveToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :inactive, :boolean
  end
end
