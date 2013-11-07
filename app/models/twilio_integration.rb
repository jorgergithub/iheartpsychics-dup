module TwilioIntegration
  def create_call(number, url)
    twilio_account.calls.create(from: "+17863295532", to: number, url: url)
  end

  def twilio_account
    @twilio_account ||= TwilioHelper.client.account
  end
end
