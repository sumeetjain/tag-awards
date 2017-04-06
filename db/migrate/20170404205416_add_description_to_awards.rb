class AddDescriptionToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :description, :text
  end
end
