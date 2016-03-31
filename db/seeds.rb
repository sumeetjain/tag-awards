# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


awards = Award.create([
  {id: 1, award_name: 'Outstanding Youth Actress', relevant_fields: 4}, 
  {id: 2, award_name: 'Outstanding Youth Actor', relevant_fields: 4}, 
  {id: 3, award_name: 'Outstanding One-Act Play', relevant_fields: 2}, 
  {id: 4, award_name: 'Outstanding Director-Musical', relevant_fields: 3}])

users = User.create([
  {id: 1, email: 'tommy@aol.com', voter_token: 'hello1', first_name: 'Tommy', last_name: 'Tutone', weight: 3, admin: true},
  {id: 2, email: 'petericketts@netscape.com', voter_token: 'i42sc4', first_name: 'Pete', last_name: 'Ricketts', weight: 1, admin: false}])

nominations = Nomination.create([
  {id: 1, nominee: 'Grace Bydalek', role: 'Natalie', show: 'Next to Normal', theater: 'Shelterbelt', user_id: 2, open: true, award_id: 1},
  {id: 2, nominee: 'Noah Jeffrey', role: 'Gavroche', show: 'Les Miserables', theater: 'Bluebarn', user_id: 1, open: true, award_id: 2},
  {id: 3, show: 'Chekhovs Gun', theater: 'Shelterbelt', user_id: 2, open: true,award_id: 3},
  {id: 4, nominee: 'Susan Baer Collins', show: 'Les Miserables', theater: 'Shelterbelt', user_id: 1, open: true, award_id: 4}])

plays = Play.create([
  {id: 1, title: 'Next to Normal', theater_id: 1},
  {id: 2, title: 'Les Miserables', theater_id: 2},
  {id: 3, title: 'Chekhovs Gun', theater_id: 1}])

theaters = Theater.create([
  {id: 1, name: 'Shelterbelt'},
  {id: 2, name: 'Bluebarn'}])

viewings = Viewing.create([
  {id: 1, date: '2016-03-01', user_id: 1, play_id: 1},
  {id: 2, date: '2016-03-03', user_id: 1, play_id: 2},
  {id: 3, date: '2016-03-15', user_id: 2, play_id: 2},
  {id: 4, date: '2016-02-13', user_id: 2, play_id: 3}])

# votes = Vote.create([
#   {id: 1, user_id: 1},
#   {id: 2, user_id: 1},
#   {id: 3, user_id: 2},
#   {id: 4, user_id: 2}])
