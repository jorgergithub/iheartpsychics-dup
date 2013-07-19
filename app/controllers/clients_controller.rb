class ClientsController < AuthorizedController
  before_filter :find_client

  def show
  end

  def add_minutes
    logger.info "Added minutes: #{params[:client].inspect}"
    if params[:client]
      if @client.add_minutes(params[:client][:minutes])
        redirect_to client_path, notice: "Minutes added to your account."
      else
        render action: "add_minutes"
      end
    end
  end

  def reset_pin
    if params[:client]
      @client.pin = params.require(:client).permit(:pin)
      if @client.save
        redirect_to client_path, notice: "Your PIN has been reset."
      else
        render action: "reset_pin"
      end
    end
  end

  protected

  def find_client
    @client = current_client
  end
end
