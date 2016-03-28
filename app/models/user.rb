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

end
