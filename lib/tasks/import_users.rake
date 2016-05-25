require "rubyXL"

task :import_users => :environment do
  desc "Import members from spreadsheet"

  sheet = RubyXL::Parser.parse(Rails.root.join("lib", "members.xlsx"))[0]

  sheet.each do |row|
    unless row.r == 1

      user = User.new({
        email: row.cells[9].value.blank? ? nil : row.cells[9].value,
        password: "0246897531!BSG",
        first_name: row.cells[1].value,
        last_name: row.cells[2].value,
        admin: false
      })

      if user.save
        puts "User - #{user.inspect}"
      else
        user.email = nil
        user.save
      end
    end
  end
end
