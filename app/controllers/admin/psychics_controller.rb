class Admin::PsychicsController < AuthorizedController
  before_filter :find_psychic

  def index
    @psychics = Psychic.includes(:user).order("users.first_name, users.last_name")
    if query = params[:q]
      @psychics = @psychics.where(<<-EOQ, query: "%#{query}%")
        CONCAT(users.first_name, ' ', users.last_name) LIKE :query OR
        users.username LIKE :query
      EOQ
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to admin_psychics_path, notice: "Psychic was successfully updated."
    else
      render action: "edit"
    end
  end

  protected

  def find_psychic
    return unless params[:id]

    @psychic = Psychic.find(params[:id])
    @user = @psychic.user
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password,
      psychic_attributes: [ :extension, :address, :city, :state, :featured,
      :zip_code, :phone, :cellular_number, :ssn, :date_of_birth,
      :emergency_contact, :emergency_contact_number, :us_citizen, :resume,
      :has_experience, :experience, :gift, :explain_gift, :age_discovered,
      :reading_style, :why_work, :friends_describe,
      :strongest_weakest_attributes, :how_to_deal_challenging_client,
      :specialties, :tools, :professional_goals, :how_did_you_hear, :other])
  end
end
