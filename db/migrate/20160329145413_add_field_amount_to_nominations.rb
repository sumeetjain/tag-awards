class AddFieldAmountToNominations < ActiveRecord::Migration
  def change
    add_column :nominations, :field_amount, :integer
  end
end
