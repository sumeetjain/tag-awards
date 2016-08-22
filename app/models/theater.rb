class Theater < ActiveRecord::Base
  has_many :plays
  accepts_nested_attributes_for :plays
  has_many :viewings, through: :plays

  def self.api_all
    theaters_hash = {}

    self.all.each do |theater|
      plays_hash = {}

      theater.plays.each do |p|
        noms = Nomination.where(theater: theater.name, show: p.title)

        plays_hash[p.title] = {}

        noms.each do |nom|
          if plays_hash[p.title][nom.nominee].nil?
            plays_hash[p.title][nom.nominee] = []
          end

          if !nom.role.blank?
            plays_hash[p.title][nom.nominee] << nom.role
            plays_hash[p.title][nom.nominee].uniq!
          end
        end
      end

      theaters_hash[theater.name] = plays_hash
    end

    return theaters_hash
  end
end
