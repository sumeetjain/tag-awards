class AddDisplayNameToPotentialNomination < ActiveRecord::Migration
  def up
    add_column :potential_nominations, :display_name, :string

    PotentialNomination.all.each do |p|
      p.display_name = p.nominatable.display_name
      p.save
    end
  end

  def down
    remove_column :potential_nominations, :display_name
  end
end
