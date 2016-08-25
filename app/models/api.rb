class Api

  def initialize
    @theaters_hash = {}
  end

  def all
    return ApiCheat.cheat
  end

  class ApiTheater
    def initialize
      @plays_hash = {}
    end
  end

  class ApiPlay
  end

  class ApiNomination
  end

  class ApiRole
    def self.parts
      @abc = Array.new
      Nomination.all do |x|
        @xyz = {:nominee => @abc}
        
        return @xyz
      end
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
  

  # def self.api_all
  #   theaters_hash = {}

  #   self.all.each do |theater|
  #     plays_hash = {}

  #     theater.plays.each do |p|
  #       noms = Nomination.where(theater: theater.name, show: p.title)

  #       plays_hash[p.title] = {}

  #       noms.each do |nom|
  #         if plays_hash[p.title][nom.nominee].nil?
  #           plays_hash[p.title][nom.nominee] = []
  #         end

  #         if !nom.role.blank?
  #           plays_hash[p.title][nom.nominee] << nom.role
  #           plays_hash[p.title][nom.nominee].uniq!
  #         end
  #       end
  #     end

  #     theaters_hash[theater.name] = plays_hash
  #   end

  #   return theaters_hash
  # end
end