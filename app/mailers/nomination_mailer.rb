class NominationMailer < ApplicationMailer
  default from: 'admin@theatreartsguild.com'
  def nomination_email(user)
    @user = user
    #the @url/@user.voter_token will take the user to their unique registration site.
    @url  = 'http://theatreartsguild.com/awards'    
    mail(to: @user.email, 
      subject: 'TAG Awards 2016 Nominations Are Open!')
  end
end

