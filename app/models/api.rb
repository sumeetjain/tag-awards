class Api < ActiveRecord::Base
	has_many :theaters
	has_many :plays
	

end