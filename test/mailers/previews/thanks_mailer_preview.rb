# Preview all emails at http://localhost:3000/rails/mailers/thanks_mailer
class ThanksMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/thanks_mailer/user_welcome_mail
  def user_welcome_mail
    ThanksMailer.user_welcome_mail
  end

end
