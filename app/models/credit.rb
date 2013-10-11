class Credit < ActiveRecord::Base
  belongs_to :client
  belongs_to :target, polymorphic: true

  scope :by_date, -> { order("created_at") }

  def parsed_time_only
    created_at.strftime("%I:%M %p")
  end

  def parsed_date_only
    created_at.strftime("%b %d, %Y")
  end
end
