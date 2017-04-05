class User < ActiveRecord::Base
   has_many :nominations
   has_many :viewings
   accepts_nested_attributes_for :viewings

   # deletes all votes for the user if the user is deleted
   has_many :votes, dependent: :destroy

   has_many :plays, through: :viewings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true

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

  # returns integer
  def viewings_weight
    weight = self.viewings.count
    if weight <= 10
      return 1
    elsif weight >= 11 && weight <= 20
      return 2
    elsif weight >= 21 && weight <= 30
      return 3
    elsif weight >= 31 && weight <= 40
      return 4
    elsif weight >= 41
      return 5
    end
  end

  #NOT CALLED ANYWHERE -- CAN DELETE?
  # def self.set_weights
  #   User.update_all(weight: 0)

  #   shows_weighing_thresholds = Viewing.shows_weighing_thresholds

  #   Viewing.select("user_id, count(*) as viewings").group("1").each do |v|
  #     # Start by setting weights just according to total viewings.
  #     if v.viewings >  shows_weighing_thresholds[:top]
  #       User.where(id: v.user_id).update_all(weight: 3)
  #     elsif v.viewings >  shows_weighing_thresholds[:middle]
  #       User.where(id: v.user_id).update_all(weight: 2)
  #     else
  #       User.where(id: v.user_id).update_all(weight: 1)
  #     end
  #   end

  #   theaters_weighing_thresholds = Viewing.theaters_weighing_thresholds

  #   User.find_by_sql("select user_id, weight, count(*) as theaters_count from (select user_id, plays.theater_id, users.weight from viewings join plays on viewings.play_id = plays.id join users on viewings.user_id = users.id group by 1, 2, 3) as user_theaters group by user_id, weight").each do |u|
  #     # Now increase the weights by the weight amount just for theaters.
  #     if u.theaters_count >  theaters_weighing_thresholds[:top]
  #       User.where(id: u.user_id).update_all(weight: (3 + u.weight))
  #     elsif u.theaters_count >  theaters_weighing_thresholds[:middle]
  #       User.where(id: u.user_id).update_all(weight: (2 + u.weight))
  #     else
  #       User.where(id: u.user_id).update_all(weight: (1 + u.weight))
  #     end
  #   end

  #   # No one's weight should be above 6 at this point, since you can only
  #   # receive a max of 3 in each weighting.
  # end

  before_create :set_secret_number
  # before_validation :nullify_duplicate_email

  def delete_previous_noms(user_id)
    @users_prev_noms = Nomination.where("user_id" => user_id)
    if @users_prev_noms != nil
      @users_prev_noms.delete_all
    end
  end

  def get_previous_noms(user_id, key)
    @users_prev_noms = Nomination.where("user_id" => user_id)
    html = ""
    if @users_prev_noms == nil
      html = ""
    elsif @users_prev_noms != nil
      @users_prev_noms.each do |nom|
        if nom.potential_nomination_id == key
          html = "selected"
        end
      end
    else
      html = ""
    end
    return html
  end

  def record_nominations(user_id, nominations_hash)
    delete_previous_noms(user_id)
    nominations_hash.each do |key, value|
      value.each do |key2, value2|
        save_nomination_object(user_id, value2)
      end
    end
  end

  def save_nomination_object(user_id, potential_nom)
    @new_nom = Nomination.new
    @new_nom.user_id = user_id
    @new_nom.potential_nomination_id = potential_nom
    @new_nom.save
  end

  def email_required?
    false
  end

  def self.to_csv
    attributes = %w[secret_number full_name]

    CSV.generate do |csv|
      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  def has_viewed?(play)
    viewings.pluck(:play_id).include?(play.id)
  end

  # Saves votes for this user's final ballot.
  # 
  # ballot_item_votes - Hash of votes being cast, where award ID is the key
  #                     and the ballot item ID is the value.
  # 
  # Returns True if successful.
  def record_final_ballot(ballot_item_votes)
    # Collect votes into an Array that can be passed directly into Vote.create.
    votes_array = ballot_item_votes.map do |award_id, ballot_item_id|
      {ballot_item_id: ballot_item_id}
    end

    votes.create(votes_array)
  end

  def has_submitted_final_ballot?
    votes.any?
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
