class PsychicApplicationsController < ApplicationController
  layout "login"

  def new
    @psychic_application = PsychicApplication.new
  end

  def create
    @psychic_application = PsychicApplication.new(application_params)
    if @psychic_application.save
      redirect_to confirmation_psychic_applications_path,
        notice: "Your application has been submitted."
    else
      render action: "new"
    end
  end

  def confirmation
  end

  protected

  def application_params
    params.require(:psychic_application).permit(:first_name, :last_name,
      :username, :password,:address, :city, :state,
      :zip_code, :landline_number, :cellular_number, :ssn, :date_of_birth,
      :emergency_contact, :emergency_contact_number, :us_citizen, :resume,
      :has_experience, :experience, :gift, :explain_gift, :age_discovered,
      :reading_style, :why_work, :friends_describe,
      :strongest_weakest_attributes, :how_to_deal_challenging_client,
      :specialties, :professional_goals, :how_did_you_hear, :other)
  end
end
