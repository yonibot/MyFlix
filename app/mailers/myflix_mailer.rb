class MyflixMailer < ActionMailer::Base
  def notify_on_registration(user)
    @user = user
    mail from: 'Admin <yoni.weisbrod@gmail.com>', to: user.email, subject: "Welcome to MyFlix, #{user.full_name}!"
  end
end