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

# The following lines were created using this as a resource: http://blog.bigbinary.com/2016/03/23/has-secure-  token-to-generate-unique-random-token-in-rails-5.html. I opted NOT to use the has_secure_token method/gem because it doesn't appear that you can make tokens less than 24 characters, which would be difficult to use since might still want to manually enter them on paper forms/ballots.

  before_create :set_voter_token

  def delete_previous_noms(user_id)
    @users_prev_noms = Nomination.where("user_id" => user_id)
    if @users_prev_noms != nil
      @users_prev_noms.delete_all
    end
  end

  #determines whether a specific nomination object has been saved previously
  #
  #takes in Integer of award_id, Integer of nom_count, and String of value_needed
  #
  #returns String of existing nomination or empty String if no previous nomination
  def nomination_value(award_id, nom_count, value_needed)
    nominations = Nomination.where("award_id" => award_id, 
      "user_id" => self.id)
    if nominations[nom_count]
      @nomination = nominations[nom_count]
      return @nomination.send(value_needed)
    else
      return ""
    end     
  end  

  #saves nominations entered by user
  #
  #takes in Integer of user_id and Hash of awards params from nominations ballot
  #
  #returns nil
  def record_nominations(user_id, nominations_hash)
    delete_previous_noms(user_id)
    nominations_hash.each do |key, value|
      @current_award = key
      value.each do |key2, value2|
        value2.each do |key3, value3|
          if value3["theater"] == "" || value3["nominee"] == ""
            next
          elsif
            save_nomination_object(user_id, @current_award, value3)
          end
        end
      end
    end
  end

  #saves object of nomination entered by user
  #
  #takes in Integer of user_id, Integer of award id, and Collection of Hashes from nested nominations_hash
  #
  #returns nil
  def save_nomination_object(user_id, current_award, value3)
    @new_nom = Nomination.new
    @new_nom.user_id = user_id
    @new_nom.award_id = current_award
    @new_nom.open = true
    @new_nom.theater = value3["theater"]
    @new_nom.nominee = value3["nominee"]
    @new_nom.role = value3["role"]
    @new_nom.show = value3["show"]
    @new_nom.save
  end
  
  private

  #assigns random key to a user
  #
  #uses SecureRandom gem
  def set_voter_token
    self.voter_token = generate_token
  end

  #generates a random 6-digit alphanumeric key
  #
  #uses SecureRandom gem
  def generate_token
    loop do
      token = SecureRandom.hex(3)
      break token unless User.where(voter_token: token).exists?
    end
  end



end
