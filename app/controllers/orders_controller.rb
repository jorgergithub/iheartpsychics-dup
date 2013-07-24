class OrdersController < AuthorizedController
  before_action :find_order

  def new
    @order = @client.orders.new(card_id: @client.card.try(:id))
  end

  def show
  end

  def create
    @order = @client.orders.new(order_params)
    if @order.save
      @order.pay
      redirect_to client_path, notice: "Your order was successfully processed"
    else
      render action: "new"
    end
  rescue Stripe::CardError
    logger.info "CardError: #{$!.message}"
    flash[:error] = $!.message
    redirect_to :new_order
  end

  private

  def find_order
    @client = current_client
    @order = @client.orders.find(params[:id]) if params[:id]
  end

  def order_params
    params.require(:order).permit(:package_id, :card_id, :stripe_token)
  end
end
