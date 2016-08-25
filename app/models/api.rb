class Api

  def initialize
    @theaters_hash = {}
  end

  def all
    return ApiNominee.nominees
  end

  class ApiTheater
    def self.theaters
      theaters_hash = {}

      Theater.all.each do |theater|
        plays_hash = {}
        theaters_hash[theater.name] = plays_hash   
      end
      return theaters_hash
    end
  end

  class ApiPlay
    def self.plays
      plays_hash = {}
      Play.all.each do |play|
        noms_hash = {}
        plays_hash[play.title] = noms_hash   
      end
      return plays_hash
    end
  end

  class ApiNominee
    def self.nominees
      noms_hash = {}

      Nomination.all.each do |nom|
        role_array = []
        noms_hash[nom.nominee] = role_array   
      end
      return noms_hash
    end
  end

  class ApiRole
    def self.roles
      role_array = []

      Nomination.all.each do |nom|
          
        role_array << nom.role    
      end
      eturn role_array
    end
  end

  class ApiCheat
    def self.cheat
      theaters_hash = {}

    Theater.all.each do |theater|
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
  
end