class AddFullNameToUser < ActiveRecord::Migration
  def change
  	add_column :users, :full_name, :string

  	 User.find_each do |user|
	
  		fullname = user.first_name + " " + user.last_name
  		user.full_name = fullname
  		user.save
  	 end
  end
end
