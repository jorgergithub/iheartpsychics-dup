class CallbacksController < AuthorizedController
  def new
    @psychic = Psychic.find(params[:psychic_id])
    @callback = current_client.callbacks.new(psychic: @psychic)
  end

  def create
    @callback = current_client.callbacks.new(callback_params)
    if @callback.save
      redirect_to root_url, notice: "Your callback has been scheduled"
    else
      render action: "edit"
    end
  end

  private

  def callback_params
    params.require(:callback).permit(:psychic_id, :wait_for)
  end
end
