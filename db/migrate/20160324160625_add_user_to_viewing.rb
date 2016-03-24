class AddUserToViewing < ActiveRecord::Migration
  def change
    add_reference :viewings, :user, index: true, foreign_key: true
    add_reference :viewings, :play, index: true, foreign_key: true
  end
end
