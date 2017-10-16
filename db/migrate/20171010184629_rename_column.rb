class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :roles, :job, :job_type
  end
end
