task :members_2017 => :environment do
  require "csv"
  require "pry"

  list = Rails.root.join('lib', 'members.csv')

  to_database = []

  CSV.foreach(list, {headers: true, return_headers: false}) do |row|
    row = row.to_h

    pw = "#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}#{rand(9)}"

    user_info = {
      full_name: "#{row['first']} #{row['last']}",
      email: row['email'],
      username: row['username'],
      password: pw,
      password_confirmation: pw
    }

    to_database << user_info
  end

  User.create(to_database)
end
