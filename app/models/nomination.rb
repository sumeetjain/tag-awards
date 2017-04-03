class Nomination < ActiveRecord::Base
  belongs_to :potential_nomination
  accepts_nested_attributes_for :potential_nomination
  belongs_to :user

  # validates :potential_nomination, uniqueness: { scope: :user, message: "You may only nominate something once!"}
end
