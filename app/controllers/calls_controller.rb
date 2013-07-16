class CallsController < ApplicationController
  protect_from_forgery :except => :notify

  def index
    # render layout: false
  end

  def notify
    logger.info "Params: #{params.inspect}"
    render nothing: true, status: :ok
  end
end
