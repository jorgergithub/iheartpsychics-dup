class OrdersController < AuthorizedController
  before_action :find_order

  def new
    @order = @client.orders.new(card_id: @client.card.try(:id))
  end

  def show
  end

  def create
    @order = @client.orders.new(order_params.merge(payment_method: "credit_card"))

    respond_to do |format|
      if @order.save
        @order.pay
        format.html { redirect_to client_path, notice: "Your order was successfully processed" }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  rescue Stripe::CardError
    logger.info "CardError: #{$!.message}"
    flash[:error] = $!.message

    respond_to do |format|
      format.html { redirect_to :new_order }
      format.js
    end
  end

  def paypal
    @order = @client.orders.new(order_params.merge(payment_method: "paypal"))
    if @order.save
      @paypal = @order.to_paypal
    else
      # TODO render action: "new"
    end
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
