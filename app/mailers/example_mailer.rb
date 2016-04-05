class ExampleMailer < ApplicationMailer
  default from: "sdjaxies@gmail.com"
  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
