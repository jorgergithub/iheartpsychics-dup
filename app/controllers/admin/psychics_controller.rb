class Admin::PsychicsController < AuthorizedController
  before_filter :find_psychic

  def index
    @psychics = Psychic.includes(:user).order("users.first_name, users.last_name")
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      @user = @psychic.user
      if @user.update_attributes(user_params)
        if @psychic.update_attributes(psychic_params)
          redirect_to admin_psychics_path, notice: "Psychic was successfully updated."
        else
          render action: "edit"
        end
      else
        render action: "edit"
      end
    end
  end

  protected

  def find_psychic
    @psychic = Psychic.find(params[:id]) if params[:id]
  end

  def user_params
    params.require(:psychic).permit(:first_name, :last_name, :username, :email)
  end

  def psychic_params
    params.require(:psychic).permit(:extension, :address, :city, :state,
      :zip_code, :landline_number, :cellular_number, :ssn, :date_of_birth,
      :emergency_contact, :emergency_contact_number, :us_citizen, :resume,
      :has_experience, :experience, :gift, :explain_gift, :age_discovered,
      :reading_style, :why_work, :friends_describe,
      :strongest_weakest_attributes, :how_to_deal_challenging_client,
      :specialties, :professional_goals, :how_did_you_hear, :other)
  end
end
