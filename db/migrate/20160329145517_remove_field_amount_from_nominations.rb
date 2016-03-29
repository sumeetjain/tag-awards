class RemoveFieldAmountFromNominations < ActiveRecord::Migration
  def change
    remove_column :nominations, :field_amount, :integer
  end
end
