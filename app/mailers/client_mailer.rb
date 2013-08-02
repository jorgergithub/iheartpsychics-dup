class ClientMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def pin_email(client, pin)
    @client = client
    @pin = pin
    mail(to: client.email, subject: "I Heart Psychics - your new account information")
  end

  def reset_pin_email(client)
    @client = client
    mail(to: client.email, subject: "Your I Heart Psychics PIN has been reset")
  end
end
