class MyflixMailer < ActionMailer::Base
  def notify_on_registration(user)
    @user = user
    mail from: 'Admin <yoni.weisbrod@gmail.com>', to: user.email, subject: "Welcome to MyFlix, #{user.full_name}!"
  end

  def send_forgot_password(user)
    @user = user
    mail(from: "Admin <'yoni.weisbrod@gmail.com'>", to: user.email, subject: "Reset your password to MyFlix")
  end

  def send_invitation_email(invitation)
    @invitation = invitation
    mail(to: invitation.recipient_email, from: "info@myflix.com", subject: "Invitation to join Myflix!")
  end

end