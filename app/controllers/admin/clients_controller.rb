class Admin::ClientsController < AuthorizedController
  before_filter :find_client

  def index
    @clients = Client.order(:id).page(params[:page]).per(params[:per])
  end

  def show
  end

  def new
    @user = User.new
    @client = @user.build_client if @user
    @phones = @client.phones.build if @client
  end

  def edit
  end

  def create
    random_password = Devise.friendly_token[0,8]

    @user = User.new
    @user.localized.update_attributes(user_params.merge({ role: "client",
      generated_password: true, password: random_password,
      password_confirmation: random_password}))

    if @user.save
      redirect_to admin_clients_path, notice: "New client was successfully created."
    else
      @client = @user.client
      @phones = @client.phones
      render action: "new"
    end
  end

  def update
    if @user.localized.update_attributes(user_params)
      redirect_to edit_admin_client_path(@client, anchor: params[:anchor]),
        notice: "Client was successfully updated."
    else
      render action: "edit"
    end
  end

  protected

  def find_client
    @client = Client.find(params[:id]) if params[:id]
    @user = @client.user if @client
    @phones = @client.phones if @client
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email,
      client_attributes: [:id, :balance, :receive_newsletters,
      phones_attributes: [:id, :number, :desc, :_destroy]])
  end
end
