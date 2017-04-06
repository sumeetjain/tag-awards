module ApplicationHelper
  def nominatables
    Play.for_voting_period(session[:year]) + Role.for_voting_period(session[:year])
  end
end
