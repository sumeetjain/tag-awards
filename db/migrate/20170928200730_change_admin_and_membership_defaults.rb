class ChangeAdminAndMembershipDefaults < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :admin, false
    change_column_default :users, :membership_active, true
  end
end
