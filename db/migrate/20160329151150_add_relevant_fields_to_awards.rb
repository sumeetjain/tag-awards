class AddRelevantFieldsToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :relevant_fields, :integer
  end
end
