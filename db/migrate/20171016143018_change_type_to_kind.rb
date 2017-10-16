class ChangeTypeToKind < ActiveRecord::Migration[5.1]
  def change
    rename_column :roles, :job_type, :job_kind
    rename_column :awards, :award_type, :award_kind
  end
end
