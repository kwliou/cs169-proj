class UserMailer < ActionMailer::Base
  #default :from => "noreply@refactored.heroku.com"
  def welcome(user)
    recipients  user.email
    from        "noreply@refactored.heroku.com"
    subject     "Welcome to re.factored!"
    body        :user => user
    #mail(:to => user.email, :subject => "Welcome to re.factored!")
  end
end
