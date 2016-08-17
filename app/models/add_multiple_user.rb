# The AddMultipleUser Class is used to read csv file.
#
# Multiple new users are added the User table from the csv file. 
require 'pry'
require 'csv'

class AddMultipleUser < ActiveRecord::Base

	def initialize
		
		file = "add_multiple_users.csv"
		@csv_array = []

		CSV.foreach(file) do |record|
			 @csv_array.push(record)
		end

	end

	def save

		@count = 0
		@failed = ""
		@csv_array.each do |record|
			@count += 1
			user = User.new
			user.secret_number 
			user.full_name = record[0]
			user.email = record[1]
			user.admin = record[2]
			user.password = "TagNumber1!"
			user.save
			
			if user.save == false
				@failed += @count.to_s + " "
			end

		end
	end

	def count
		return @count
	end

	def failed
		
		if @failed == ""
			return "None"
		else
			return @failed
		end
	end
end
