class ClientWeeklyUsageMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def weekly_usage(client, calls, cost, duration)
    @client = client
    @calls = calls
    @cost = cost
    @duration = duration

    mail(to: @client.email, subject: "I Heart Psychics - Weekly Usage Report")
  end
end
