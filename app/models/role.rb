class Role < ApplicationRecord
  belongs_to :artist
  belongs_to :play
  validates :artist_id, presence: true
  validates :play_id, presence: true
  validates :job_type, presence: true
  validates :name, presence: true, length: { maximum: 50 },
            uniqueness: { scope: [:artist_id, :play_id] }

  enum job_type: {Director: 1, Actor: 2, Actress: 3, "Music Director": 4,
             Choreographer: 5, "Sound Designer": 6, "Props Designer": 7,
             "Set Designer": 8, "Costume Designer": 9, "Lighting Designer": 10,
             Ensemble: 11, Writer: 12, Other: 13}
end
