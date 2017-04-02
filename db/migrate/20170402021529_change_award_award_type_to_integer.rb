class ChangeRoleJobToInteger < ActiveRecord::Migration
  def up
    remove_column :awards, :award_type
    add_column :awards, :award_type, :integer
  end

  def down
    remove_column :awards, :award_type
    add_column :awards, :award_type, :string
  end
end
