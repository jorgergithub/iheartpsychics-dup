class Admin::ClientsController < AuthorizedController
  before_filter :find_client

  def index
    @clients = Client.order(:id).page(params[:page]).per(params[:per])
  end

  def new
    @user = User.new
    @client = @user.build_client(user: @user)
  end

  def edit
  end

  def create
    @user = Client.new(user_params)
    if @user.save
      redirect_to admin_clients_path, notice: "New client was successfully created."
    else
      render action: "show"
    end
  end

  def update
    if @user.localized.update_attributes(user_params)
      redirect_to admin_clients_path, notice: "Client was successfully updated."
    else
      render action: "edit"
    end
  end

  protected

  def find_client
    @client = Client.find(params[:id]) if params[:id]
    @user = @client.user if @client
  end

 def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email,
      client_attributes: [:id, :balance, :receive_newsletters,
      phones_attributes: [:id, :number, :desc, :_destroy]])
  end
end
