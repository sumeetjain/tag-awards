require 'pry'
class AddFullNameToUser < ActiveRecord::Migration
  def change
  	add_column :users, :full_name, :string

  	User.find_each do |user|


  		fullname = user.first_name + " " + user.last_name
  		user.full_name = fullname

  		binding.pry

  	end
  # 	all = ActiveRecord::Base.connection.select_all('SELECT * FROM Users')

  # 	all.each do |record|
  # 		id = record['id']
  # 		firstname = record["first_name"]
  # 		lastname = record["last_name"]

  # 		fullname = firstname + " " + lastname

  		
		# ActiveRecord::Base.connection.execute("UPDATE Users SET full_name = \"#{fullname}\" WHERE id = #{id}")
  # 		#update sql here
  # 	end


  end
end
