class NewsletterMailer < ActionMailer::Base
  default from: "newsletters@iheartpsychics.co"

  def send_newsletter(newsletter, client)
    @newsletter = newsletter
    @client = client

    @body = ERB.new(newsletter.body).result(binding)

    mail(to: @client.email, subject: @newsletter.title)
  end
end
