class ChangeRoleJobToInteger < ActiveRecord::Migration
  def up
    change_column :roles, :job, :integer
  end

  def down
    change_column :roles, :job, :string
  end
end
