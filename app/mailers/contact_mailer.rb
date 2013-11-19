class ContactMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def new_message(message)
    @message = message
    mail(to: "info@iheartpsychics.co", subject: "I Heart Psychics - New Contact Us message")
  end
end
