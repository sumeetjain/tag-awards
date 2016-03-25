class CreateViewings < ActiveRecord::Migration
  def change
    create_table :viewings do |t|
      t.date :date

      t.timestamps null: false
    end
  end
end
