class AddTheaterToNominations < ActiveRecord::Migration
  def change
    add_column :nominations, :theater, :string
  end
end
