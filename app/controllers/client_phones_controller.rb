class ClientPhonesController < AuthorizedController
  before_filter :find_phone

  def new
    @phone = ClientPhone.new
  end

  def edit
  end

  def create
    @phone = current_client.phones.new(phone_params)
    if @phone.save
      redirect_to client_path, notice: "New phone was successfully created."
    else
      render action: "show"
    end
  end

  def update
    if @phone.update_attributes(phone_params)
      redirect_to client_path, notice: "Phone was successfully updated."
    else
      render action: "show"
    end
  end

  def destroy
    @phone.destroy

    redirect_to client_path, notice: 'Game was successfully deleted.'
  end

  protected

  def find_phone
    @client = current_client
    @phone = @client.phones.find(params[:id]) if params[:id]
  end

  def phone_params
    params.require(:client_phone).permit(:number, :desc)
  end
end
