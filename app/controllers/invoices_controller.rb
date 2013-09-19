class InvoicesController < AuthorizedController
  before_action :find_invoice

  def index
    @invoices = @psychic.invoices.pending.order("created_at")
      .page(params[:page]).per(params[:per])
  end

  def show
  end

  private

  def find_invoice
    @psychic = current_psychic
    @invoice = @psychic.invoices.find(params[:id]) if params[:id]
  end
end
