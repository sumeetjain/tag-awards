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

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address#overwrite-devises-find_for_database_authentication-method-in-user-model
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(secret_number) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:secret_number) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

# The following lines were created using this as a resource: http://blog.bigbinary.com/2016/03/23/has-secure-  token-to-generate-unique-random-token-in-rails-5.html. I opted NOT to use the has_secure_token method/gem because it doesn't appear that you can make tokens less than 24 characters, which would be difficult to use since might still want to manually enter them on paper forms/ballots.

  before_create :set_secret_number
  before_validation :nullify_duplicate_email

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
  #returns True (because objects are automatically set to True: open)
  def save_nomination_object(user_id, current_award, value3)
    @new_nom = Nomination.new
    @new_nom.user_id = user_id
    @new_nom.award_id = current_award
    @new_nom.open = true
    # Chris added below 'approved' line for Admin to change to 'true' when it passes their check. If 'true', the nomination will appear in the ballot_box for user vote
    @new_nom.approved = false
    @new_nom.theater = value3["theater"]
    @new_nom.nominee = value3["nominee"]
    @new_nom.role = value3["role"]
    @new_nom.show = value3["show"]
    @new_nom.save
  end

  def email_required?
    false
  end
  
  private

  #assigns random key to a user
  #
  #uses SecureRandom gem
  def set_secret_number
    self.secret_number = generate_token
  end

  def nullify_duplicate_email
    if User.where(email: self.email).count > 0
      self.email = nil
    end
  end

  #generates a random 6-digit alphanumeric key
  #
  #uses SecureRandom gem
  def generate_token
    loop do
      token = SecureRandom.hex(3)
      break token unless User.where(secret_number: token).exists?
    end
  end



end
