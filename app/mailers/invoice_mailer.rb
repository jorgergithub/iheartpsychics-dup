class InvoiceMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def notify(invoice_id)
    Rails.logger.info "Delivering invoice notification for invoice id #{invoice_id}"
    @invoice = Invoice.find(invoice_id)
    @psychic = @invoice.psychic
    mail(to: @psychic.email, subject: "Invoice ##{@invoice.number} is ready.")
  end

  def notify_payment(invoice_id)
    Rails.logger.info "Delivering invoice payment notification for invoice id #{invoice_id}"
    @invoice = Invoice.find(invoice_id)
    @psychic = @invoice.psychic
    mail(to: @psychic.email, subject: "Invoice ##{@invoice.number} payment notification.")
  end
end
