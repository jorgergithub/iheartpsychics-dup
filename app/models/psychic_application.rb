class PsychicApplication < ActiveRecord::Base
  mount_uploader :resume, ResumeUploader

  validates_presence_of :first_name, :last_name, :username, :password,
      :address, :city, :state,
      :zip_code, :landline_number, :cellular_number, :ssn, :date_of_birth,
      :emergency_contact, :emergency_contact_number, :us_citizen, :resume,
      :has_experience, :experience, :gift, :explain_gift, :age_discovered,
      :reading_style, :why_work, :friends_describe,
      :strongest_weakest_attributes, :how_to_deal_challenging_client,
      :specialties, :professional_goals, :how_did_you_hear, :other
end
