class TrainingItem < ActiveRecord::Base
  def reviewed?
    reviewed_at.present?
  end

  def reviewed!
    update_attributes reviewed_at: Time.zone.now
  end
end
