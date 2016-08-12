class RemoveRelevantFieldsFromAwards < ActiveRecord::Migration
  def change
    remove_column :awards, :relevant_fields, :integer
    
  end
end
