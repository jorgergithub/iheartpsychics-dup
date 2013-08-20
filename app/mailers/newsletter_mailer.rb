class NewsletterMailer < ActionMailer::Base
  default from: "newsletters@iheartpsychics.co"

  def send_newsletter(newsletter, client)
    @newsletter = newsletter
    @client = client

    body = ERB.new(newsletter.body).result(binding)

    format.html { render :inline => body }
  end
end
