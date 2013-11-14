class InvoiceMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def notify(invoice_id)
    Rails.logger.info "Delivering invoice notification for invoice id #{invoice_id}"
    @invoice = Invoice.find(invoice_id)
    @psychic = @invoice.psychic

    mail(to: @psychic.email, subject: "I Heart Psychics - Your Weekly Invoice Report")
  end

  def notify_payment(invoice_id)
    Rails.logger.info "Delivering invoice payment notification for invoice id #{invoice_id}"
    @invoice = Invoice.find(invoice_id)
    @psychic = @invoice.psychic

    title = "I Heart Psychics - Invoice ##{@invoice.number} Payment Notification"
    mail(to: @psychic.email, subject: title)
  end
end
