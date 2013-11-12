class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    @user.build_client
    @user.client.phones.build
  end

  def create
    @user = User.new
    @user.localized.update_attributes(user_params.merge({ role: "client" }))

    if @user.save
      redirect_to new_user_session_path, :notice => "Please confirm your account by clicking the email we just sent you"
    else
      render action: "new"
    end
  end

  def update
    super
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username,
      :email, :password, :password_confirmation,
      client_attributes: [:id, phones_attributes: [:id, :desc, :number]])
  end
end
