require 'pry'

class AddAwardTypeToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :award_type, :string
  	
  	Award.find_each do |award|
  		if award.relevant_fields == 4
  			award.award_type = "acting"
  		elsif award.relevant_fields == 2
  			award.award_type = "production"
  		elsif award.relevant_fields == 3
  			award.award_type = "technical"
  		end
  		award.save
  	end
  end
end
