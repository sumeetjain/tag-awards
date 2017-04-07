class User < ActiveRecord::Base
   has_many :nominations
   has_many :viewings
   accepts_nested_attributes_for :viewings
   accepts_nested_attributes_for :nominations

   # deletes all votes for the user if the user is deleted
   has_many :votes, dependent: :destroy

   has_many :plays, through: :viewings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true
  validates :username, presence: true


  # determines weight of nominations based on a user's viewing and updates the user's weight
  # used for determining nominations weighted score
  #
  # year - string of numerical year "2017"
  # 
  # updates all user's weight column based on the year's viewings
  def self.viewings_weight(year)
    self.all.each do |user|
      count = user.viewings.for_voting_period(year).count
      if count <= 10
        weight = 1
      elsif count >= 11 && count <= 20
        weight = 2
      elsif count >= 21 && count <= 30
        weight = 3
      elsif count >= 31 && count <= 40
        weight = 4
      elsif count >= 41
        weight = 5
      end
      user.update(weight: weight)
    end
  end


  def delete_previous_noms(user_id)
    @users_prev_noms = Nomination.where(user_id: user_id)
    if @users_prev_noms != nil
      @users_prev_noms.delete_all
    end
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

  #Used to decide whether to display ballot for voting or not. Can only vote once.
  def has_submitted_final_ballot?
    votes.any?
  end

end
