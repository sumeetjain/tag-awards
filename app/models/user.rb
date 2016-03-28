class User < ActiveRecord::Base
   has_many :nominations
   has_many :viewings
   has_many :plays, through: :viewings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def record_nominations(user_id, nominations_hash)
    nominations_hash.each do |key, value|
      @current_award = key
      value.each do |key2, value2|
        value2.each do |key3, value3|
          if value3["theater"].empty?
            next
          elsif
            @new_nom = Nomination.new
            @new_nom.user_id = user_id
            @new_nom.award_id = @current_award
            @new_nom.nominee = value3["nominee"]
            @new_nom.role = value3["role"]
            @new_nom.save
          end
        end
      end
    end
  end
end

#delete open/approved columns from table?
#add theater column to table
# 1. recording new nominations
# 2. overwriting old ones (because if a person submits the form a few times, they shouldn't end up having given 10 nominations. 5 is the max per person.)
