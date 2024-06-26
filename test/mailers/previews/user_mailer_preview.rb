# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.find_by(email: "suisui140409@icloud.com")
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end
end
