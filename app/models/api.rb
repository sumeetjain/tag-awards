
class Api

  def initialize
    @theaters_hash = {}
  end

  def all
    return ApiTheater.theaters
  end

  class ApiTheater
    def self.theaters
      theaters_hash = {}
      Theater.all.each do |theater|
        plays_hash = ApiPlay.plays(theater)
        theaters_hash[theater.name] = plays_hash   
      end
      return theaters_hash
    end
  end

  class ApiPlay
    def self.plays(theater)
      plays_hash = {}
      Play.where(theater_id: theater.id).each do |play| 
       
        noms_hash = ApiNominee.nominees(theater, play)
        plays_hash[play.title] = noms_hash   
      end
      return plays_hash
    end
  end

  class ApiNominee
    def self.nominees(theater, play)
      noms_hash = {}

      Nomination.where(theater: theater.name, show: play.title).each do |nom|
        role_array = ApiRole.roles(theater, play, nom)
        noms_hash[nom.nominee] = role_array   
      end
      return noms_hash
    end
  end

  class ApiRole
    def self.roles(theater, play, nomination)
      role_array = []
      Nomination.where(theater: theater.name, show: play.title, nominee: nomination.nominee).each do |nom|
       
        if nom.nominee.nil?
          role_array = []
        end

        if !nom.role.blank?
          role_array << nom.role
          role_array.uniq!
        end
      end
      return role_array
    end
  end  
end