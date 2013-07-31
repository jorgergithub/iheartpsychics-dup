class OrderMailer < ActionMailer::Base
  default from: "orders@iheartpsychic.com"

  def confirmation_email(order)
    @order = order
    @client = order.client
    mail(to: @client.email, subject: "I Heart Psychic new order notification")
  end
end
