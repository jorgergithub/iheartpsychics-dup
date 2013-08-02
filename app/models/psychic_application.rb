class PsychicApplication < ActiveRecord::Base
  mount_uploader :resume, ResumeUploader

  scope :pending, -> { where("approved_at IS NULL AND declined_at IS NULL") }

  validates_presence_of :first_name, :last_name, :username, :password,
      :email, :address, :city, :state,
      :zip_code, :landline_number, :cellular_number, :ssn, :date_of_birth,
      :emergency_contact, :emergency_contact_number, :us_citizen, :resume,
      :has_experience, :experience, :gift, :explain_gift, :age_discovered,
      :reading_style, :why_work, :friends_describe,
      :strongest_weakest_attributes, :how_to_deal_challenging_client,
      :tools, :specialties, :professional_goals, :how_did_you_hear

  def full_name
    "#{first_name} #{last_name}"
  end

  def decline!
    ActiveRecord::Base.transaction do
      self.declined_at = Time.now
      self.save!

      PsychicMailer.declined_email(self).deliver
    end
  end

  def approve!
    ActiveRecord::Base.transaction do
      user = User.new(create_as: "psychic")
      %w[first_name last_name username password email].each do |f|
        user.send("#{f}=", send(f))
      end
      user.skip_confirmation!
      user.save!

      psychic = user.psychic
      fields = %w[address city state zip_code landline_number cellular_number ssn
                  date_of_birth emergency_contact emergency_contact_number
                  us_citizen resume has_experience experience gift explain_gift
                  age_discovered  reading_style why_work friends_describe
                  strongest_weakest_attributes how_to_deal_challenging_client
                  specialties professional_goals how_did_you_hear other]
      fields.each do |f|
        psychic.send("#{f}=", send(f))
      end
      psychic.save!

      self.approved_at = Time.now
      self.save!

      PsychicMailer.approved_email(psychic).deliver
    end
  end
end
