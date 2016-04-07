class BallotMailer < ApplicationMailer
  def ballot_email(user)
    @user = user
    @url  = 'http://theatreartsguild.com/awards'    
    mail(to: @user.email, 
      subject: 'Ballots are now available for the 2016 TAG Awards!')
  end
end
