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

  def delete_previous_noms(user_id)
    @users_prev_noms = Nomination.where("user_id" => user_id)
    if @users_prev_noms != nil
      @users_prev_noms.delete_all
    end
  end

  def nomination_value(award_id, nom_count, value_needed)
    nominations = Nomination.where("award_id" => award_id, 
      "user_id" => self.id)
    if nominations[nom_count]
      @nomination = nominations[nom_count]
      if value_needed == "theater"
        return @nomination.theater
      end
      if value_needed == "show"
        return @nomination.show
      end
      if value_needed == "nominee"
        return @nomination.nominee
      end    
      if value_needed == "role"
        return @nomination.role
      end
    else
      return ""
    end     
  end  

  def record_nominations(user_id, nominations_hash)
    delete_previous_noms(user_id)
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
            @new_nom.theater = value3["theater"]
            @new_nom.nominee = value3["nominee"]
            @new_nom.role = value3["role"]
            @new_nom.show = value3["show"]
            @new_nom.save
          end
        end
      end
    end
  end
end

# figure out exactly what open/approved columns functionality is
# find way to only display fields relevant to nomination