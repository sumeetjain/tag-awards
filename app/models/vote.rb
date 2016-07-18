class Vote < ActiveRecord::Base
  belongs_to :ballot_item
  belongs_to :user

  def self.bulk_export
    attributes = {
      "award" => "awards.award_name AS award",
      "secret_number" => "users.secret_number",
      "theater" => "theaters.name AS theater",
      "title" => "plays.title",
      "nominee" => "ballot_items.nominee",
      "role" => "ballot_items.role"
    }

    CSV.generate do |csv|
      self.joins(:user, {ballot_item: [{play: :theater}, :award]}).select(attributes.values.join(", ")).each do |user|
        csv << user.attributes.values_at(*attributes.keys)
      end
    end
  end

  def self.export_viewings
    attributes = {
      "secret_number" => "users.secret_number",
      "theater" => "theaters.name AS theater",
      "title" => "plays.title"
    }

    CSV.generate do |csv|
      Viewing.joins(:user, {play: :theater}).select(attributes.values.join(", ")).each do |user|
        csv << user.attributes.values_at(*attributes.keys)
      end
    end
  end
end
