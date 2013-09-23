class Admin::InvoicesController < AuthorizedController
  before_filter :find_invoice

  def index
    @invoices = Invoice.pending.order("id")
      .page(params[:page]).per(params[:per])
  end

  def show
    render "invoices/show"
  end

  def update
    if params[:commit] == "Approve"
      @invoice.approve!
      redirect_to admin_invoices_path,
        notice: "Psychic approved successfully."
    elsif params[:commit] == "Decline"
      @invoice.decline!
      redirect_to admin_invoices_path,
        notice: "Psychic declined successfully."
    end
  end

  protected

  def find_invoice
    @invoice = Invoice.find(params[:id]).localized if params[:id]
  end
end
