class OrderMailer < ActionMailer::Base
  default from: "orders@iheartpsychics.co"

  def confirmation_email(order)
    @order = order
    @client = order.client
    mail(to: @client.email, subject: "I Heart Psychics new order notification")
  end
end
