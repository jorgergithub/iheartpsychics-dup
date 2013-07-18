class ClientCall < ActiveRecord::Base
  belongs_to :client

  scope :unprocessed, -> { where("processed IS NULL") }
  scope :processed, -> { where("processed IS NOT NULL") }

  def formatted_duration
    formatted = Time.at(duration.try(:to_i)).utc.strftime("%Hh %Mm %Ss")
    formatted.gsub!("00h ", "")
    formatted.gsub!("00m ", "")
    formatted
  end

  def parsed_start_time
    Time.parse(start_time)
  end

  def parsed_end_time
    Time.parse(end_time)
  end
end
