class ClientsController < AuthorizedController
  before_filter :find_client

  def show
  end

  def add_minutes
    if params[:client]
      if @client.add_minutes(params[:client][:minutes])
        redirect_to client_path, notice: "Minutes added to your account."
      else
        render action: "add_minutes"
      end
    else
      @client.minutes = nil
    end
  end

  def reset_pin
    if params[:client]
      @client.pin = params.require(:client).permit(:pin)[:pin]
      if @client.save
        redirect_to client_path, notice: "Your PIN has been reset."
      else
        render action: "reset_pin"
      end
    end
  end

  def make_favorite
    @client.favorite_psychic_id = params[:psychic_id]
    if @client.save
      redirect_to client_path, notice: "New psychic marked as favorite."
    else
      redirect_to client_path, error: "Could not mark as favorite."
    end
  end

  protected

  def find_client
    @client = current_client
  end
end
