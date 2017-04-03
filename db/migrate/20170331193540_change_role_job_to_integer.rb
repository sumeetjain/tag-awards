class ChangeRoleJobToInteger < ActiveRecord::Migration
  def up
    remove_column :roles, :job
    add_column :roles, :job, :integer
  end

  def down
    remove_column :roles, :job
    add_column :roles, :job, :string
  end
end
