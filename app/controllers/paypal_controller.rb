class PaypalController < ApplicationController
  def callback
    render nothing: true
  end
end
