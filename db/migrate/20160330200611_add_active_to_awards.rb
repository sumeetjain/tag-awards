class AddActiveToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :active, :boolean, default: true
  end
end
