class PlayForCurrentYear < Play 
  def PlayForCurrentYear.all
    return VotingPeriod.find(2).plays
  end
end