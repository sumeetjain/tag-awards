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

# The following lines were created using this as a resource: http://blog.bigbinary.com/2016/03/23/has-secure-  token-to-generate-unique-random-token-in-rails-5.html. I opted NOT to use the has_secure_token method because it doesn't appear that you can make tokens less than 24 characters, which would be difficult to use since might still want to manually enter them on paper forms/ballots.

  before_create :set_voter_token

  private

  def set_voter_token
    self.voter_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(4)
      break token unless User.where(voter_token: token).exists?
    end
  end



end
