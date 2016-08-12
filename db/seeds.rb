# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


awards = Award.create([
  {award_name: 'Outstanding Youth Actress', relevant_fields: 4}, 
  {award_name: 'Outstanding Youth Actor', relevant_fields: 4}, 
  {award_name: 'Outstanding One-Act Play', relevant_fields: 2}, 
  {award_name: 'Outstanding Director-Musical', relevant_fields: 3},
  {award_name: 'Outstanding Youth Tech Award', relevant_fields: 1}])

users = User.create([
  {email: 'tommy@aol.com', password: 'hello314', full_name: 'Tommy Tutone', weight: 3, admin: true},
  {email: 'petericketts@netscape.com', password: 'isuckl0ts', full_name: 'Pete Ricketts', weight: 1, admin: false}])

nominations = Nomination.create([
  {nominee: 'Grace Bydalek', role: 'Natalie', show: 'Next to Normal', theater: 'Shelterbelt', user_id: 2, open: true, award_id: 1},
  {nominee: 'Noah Jeffrey', role: 'Gavroche', show: 'Les Miserables', theater: 'Bluebarn', user_id: 1, open: true, award_id: 2},
  {show: 'Chekhovs Gun', theater: 'Shelterbelt', user_id: 2, open: true,award_id: 3},
  {nominee: 'Susan Baer Collins', show: 'Les Miserables', theater: 'Shelterbelt', user_id: 1, open: true, award_id: 4}])

plays = Play.create([
  {title: 'Next to Normal', theater_id: 1},
  {title: 'Les Miserables', theater_id: 2},
  {title: 'Chekhovs Gun', theater_id: 1}])

theaters = Theater.create([
  {name: 'Shelterbelt'},
  {name: 'Bluebarn'}])

viewings = Viewing.create([
  {date: '2016-03-01', user_id: 1, play_id: 1},
  {date: '2016-03-03', user_id: 1, play_id: 2},
  {date: '2016-03-15', user_id: 2, play_id: 2},
  {date: '2016-02-13', user_id: 2, play_id: 3}])

# votes = Vote.create([
#   {user_id: 1},
#   {user_id: 1},
#   {user_id: 2},
#   {user_id: 2}])
