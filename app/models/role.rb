class Role < ApplicationRecord
  belongs_to :artist
  belongs_to :play
  has_many   :nominatables, as: :nominee, dependent: :destroy
  validates  :job_type, presence: true
  validates  :character, length: { maximum: 50 },
             uniqueness: { scope: [:artist_id, :play_id, :job_type] }

  enum job_type: {Director: 1, Actor: 2, Actress: 3, "Music Director": 4,
             Choreographer: 5, "Sound Designer": 6, "Props Designer": 7,
             "Set Designer": 8, "Costume Designer": 9, "Lighting Designer": 10,
             Ensemble: 11, Writer: 12, Other: 13}

  def display_name
    name = "#{artist.name}"
    name += !character ? " - #{job_type}, " : " as #{character}, "
    name += "#{play.title}, #{play.theater.name}"
  end
end
