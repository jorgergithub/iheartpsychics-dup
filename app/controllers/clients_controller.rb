class ClientsController < AuthorizedController
  before_filter :find_client

  def show
    redirect_to :new_order unless @client.minutes?
    unless @client.pin?
      @pin = @client.set_random_pin
      ClientMailer.pin_email(@client, @pin).deliver
    end
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
      @order = @client.orders.new
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
    psychic = Psychic.find(params[:psychic_id])
    @client.favorite_psychics << psychic
    if @client.save
      redirect_to :back, notice: "#{psychic.full_name} marked as favorite."
    else
      redirect_to :back, error: "Could not mark as favorite."
    end
  end

  def remove_favorite
    psychic = Psychic.find(params[:psychic_id])
    @client.favorite_psychics.delete(psychic)
    if @client.save
      redirect_to :back, notice: "#{psychic.full_name} removed from favorites."
    else
      redirect_to :back, error: "Could not remove as favorite."
    end
  end

  protected

  def find_client
    @client = current_client
  end
end
