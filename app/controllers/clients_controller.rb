class ClientsController < AuthorizedController
  before_action :find_client
  before_action :update_time_zone

  layout :determine_layout

  def show
    unless @client.balance?
      redirect_to :new_order
      return
    end

    unless @client.pin?
      @pin = @client.set_random_pin
      ClientMailer.delay.pin_email(@client, @pin)
    end

    @credits = @client.credits.order('id desc').page(params[:page_credits]).per(params[:per])
    @phones = @client.phones.order(:id).page(params[:page_phones]).per(params[:per])
    @psychics = @client.psychics.order(:id).page(params[:page_psychics]).per(params[:per])
    @processed_calls = @client.calls.processed.order(id: :desc).page(params[:page_processed_calls]).per(params[:per])
    @callbacks = @client.callbacks.current.page(params[:page_callbacks]).per(params[:per])
  end

  def edit
  end

  def update
    tmp_params = user_params

    if tmp_params[:password].empty?
      tmp_params.delete('password')
      tmp_params.delete('password_confirmation')
    end

    if @client.user.update_attributes(tmp_params)
      redirect_to edit_client_path, notice: "Client was successfully updated."
    else
      render action: "edit"
    end
  end

  def add_credits
    if params[:client]
      if @client.add_credits(params[:client][:balance])
        redirect_to client_path, notice: "Credits added to your balance."
      else
        render action: "add_credits"
      end
    else
      @client.balance = nil
      @order = @client.orders.new
    end
  end

  def reset_pin
    if params[:client]
      pin = params.require(:client).permit(:pin)[:pin]
      if @client.reset_pin(pin)
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
      redirect_to :back, notice: "#{psychic.alias_name} marked as favorite."
    else
      redirect_to :back, error: "Could not mark as favorite."
    end
  end

  def remove_favorite
    psychic = Psychic.find(params[:psychic_id])
    @client.favorite_psychics.delete(psychic)
    if @client.save
      redirect_to :back, notice: "#{psychic.alias_name} removed from favorites."
    else
      redirect_to :back, error: "Could not remove as favorite."
    end
  end

  protected

  def determine_layout
    "main"
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email,
      :password, :password_confirmation, :time_zone, client_attributes: [:id, :receive_newsletters])
  end

  def find_client
    redirect_to :root unless current_user.client?
    @client = current_client
  end

  def update_time_zone
    if current_user.time_zone.blank? && cookies.has_key?("jstz_time_zone")
      current_user.update_attribute(:time_zone, cookies["jstz_time_zone"])
    end
  end
end
