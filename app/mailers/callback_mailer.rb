class CallbackMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def notify_client(callback)
    @callback = callback

    mail to: @callback.client_email, subject: "I Heart Psychics - your callback was cancelled"
  end
end
