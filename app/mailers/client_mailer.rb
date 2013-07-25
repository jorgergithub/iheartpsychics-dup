class ClientMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.com"

  def pin_email(client, pin)
    @client = client
    @pin = pin
    mail(to: client.email, subject: "I Heart Psychics - your new account information")
  end
end
