# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(username: 'joshmireles',
             email: 'joshmireles@cox.net',
             full_name: 'Josh Mireles',
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             membership_active: true)

VotingPeriod.create!(year: 2017, active: true, nominations_active: true)
VotingPeriod.create!(year: 2018, active: false)

(1..10).each do |i|
  Theater.create!(name: "Theater #{i}")
end

(1..60).each do |i|
  Play.create!(title: "Play #{i}",
              voting_period_id: [1,2].sample,
              theater_id: (1..10).to_a.sample )
end

(1..30).each do |i|
  Viewing.create!(user_id: 1, play_id: i * 2)
end

(1..180).each do |i|
  Artist.create!(name: "Artist #{i}")
end

(1..60).each do |i|
  Role.create!(play_id: i, artist_id: i, character: "Role #{i}", job_kind: :Actor)
end

(61..120).each do |i|
  Role.create!(play_id: i - 60, artist_id: i, character: "Role #{i}", job_kind: :Actress)
end

(121..180).each do |i|
  Role.create!(play_id: i - 120, artist_id: i, job_kind: :Director)
end

award_kinds = [:acting, :directing, :technical, :production, :ensemble]
(1..10).each do |i|
  Award.create!(name: "Award #{i}", description: "This is an award.",
               award_kind: award_kinds[i % 5])
end

(1..20).each do |i|
  Nominatable.create!(nominee: Role.find(i), award_id: i % 4 + 1)
end

(121..140).each do |i|
  Nominatable.create!(nominee: Role.find(i), award_id: i % 4 + 5)
end

(1..20).each do |i|
  Nominatable.create!(nominee: Play.find(i), award_id: i % 2 + 9)
end
