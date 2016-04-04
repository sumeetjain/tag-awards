class ApplicationMailer < ActionMailer::Base
  default from: ENV["MASS_VOTING_EMAIL"]
  layout 'mailer'

  def nomination_period_email(user)
    @user = user
    mail(to: @user.email, subject: 'TAG Awards Nominations Open')
  end

end
