# This class is used to add new users to the User table
# The class read csv files to add multiple users at time
# The record should be in the following order 
# full name, email address, admin rights (true/false or blank)
class AddMultiple 

	def initialize(file)
	
		csv_text = file.read
	
		@csv_array = []
		
		CSV.foreach(file.tempfile) do |record|

			 @csv_array.push(record)
		end
	end
# This function is used to save new record to the User Database
# 
# This function will record the succesful record count the records that failed.

	def save

		count = 0
		@failed = ""
		@success = 0
		@csv_array.each do |record|
			count += 1
			user = User.new
			user.secret_number 
			user.full_name = record[0]
			user.email = record[1]
			user.admin = record[2]
			user.password = "TagNumber1!"
			user.save
			
			if user.save == false
				if @failed == ""
					@failed += count.to_s
				else
					@failed += "," + count.to_s
				end
			else
				@success += 1
			end

		end
	end
# returns the number of succesful records added. Success is set via the save function.
	def success
		return @success
	end
# returns the number of failed rows. Failed is set via the save function.
	def failed
		
		if @failed == ""
			return "None"
		else
			return @failed
		end
	end
end