class ClientPhonesController < AuthorizedController
  before_filter :find_phone

  def new
    @phone = ClientPhone.new
  end

  def edit
  end

  def create
    @phone = current_client.phones.build.tap do |object|
      object.localized.assign_attributes(phone_params)
    end

    if @phone.save
      redirect_to client_path, notice: "New phone was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @phone.localized.update_attributes(phone_params)
      redirect_to client_path, notice: "Phone was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @phone.destroy

    redirect_to client_path, notice: 'Phone was successfully deleted.'
  end

  protected

  def find_phone
    @client = current_client
    @phone = @client.phones.find(params[:id]).localized if params[:id]
  end

  def phone_params
    params.require(:client_phone).permit(:number, :desc)
  end
end
