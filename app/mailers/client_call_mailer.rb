class ClientCallMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def client_call_statistics(call)
    @call = call
    @client = call.client
    @psychic = call.psychic

    title = "Your I Heart Psychics call with #{@psychic.full_name}"
    mail(to: @client.email, subject: title)
  end
end
