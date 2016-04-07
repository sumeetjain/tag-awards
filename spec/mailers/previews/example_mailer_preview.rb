# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class ExampleMailerPreview < ActionMailer::Preview
  default from: "ENV["MASS_VOTING_EMAIL"]"
  def nom_period_email_preview
    ExampleMailer.nomination_period_email(User.first)
  end
  def sample_mail_preview
    ExampleMailer.sample_email(User.first)
  end
end
