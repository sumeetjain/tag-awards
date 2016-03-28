class User < ActiveRecord::Base
   has_many :nominations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


 
  
  validates :first_name, presence: true
  validates :last_name, presence: true

  def record_nominations(nominations_hash)
    # loop through that hash and creates/modifies
    # nominations for this user as needed.

    # 1. recording new nominations
    # 2. overwriting old ones (because if a person submits the form a few times, they shouldn't end up having given 10 nominations. 5 is the max per person.)
  end
end
