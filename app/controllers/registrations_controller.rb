class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js

  def new
    @user = User.new
    @user.build_client
    @user.client.phones.build
  end

  def create
    @user = User.new
    @user.localized.update_attributes(user_params.merge({ role: "client" }))

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_user_session_path, :notice => "Please confirm your account by clicking the email we just sent you" }
        format.js
      else
        format.html { render action: "new" }
        format.js { render :new }
      end
    end
  end

  def update
    super
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username,
      :email, :password, :password_confirmation,
      client_attributes: [:id, :birthday, phones_attributes: [:id, :desc, :number]])
  end
end
