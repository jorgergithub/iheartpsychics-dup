class PaypalController < ApplicationController
  protect_from_forgery except: [:success, :cancel]

  def callback
    Rails.logger.info "[PAYPAL-CALLBACK] #{params.inspect}"

    if params[:payment_status] == "Completed"
      if order = Order.find(params[:invoice])
        order.pay_with_paypal(params)
      else
        Rails.logger.error "Got a notification from PayPal for order #{params[:invoice]} but the order was not found."
      end
    end

    render nothing: true
  end

  def success
    Rails.logger.info "[PAYPAL-SUCCESS] #{params.inspect}"
    redirect_to client_path, notice: "Your order was successfully processed"
  end

  def cancel
    Rails.logger.info "[PAYPAL-CANCEL] #{params.inspect}"
    redirect_to client_path, error: "Your order purchase was successfully cancelled"
  end
end
