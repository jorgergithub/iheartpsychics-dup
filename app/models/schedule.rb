class Schedule < ActiveRecord::Base
  include ActionView::Helpers::TranslationHelper
  include I18n::Alchemy

  belongs_to :psychic

  scope :weekly, -> { where("date BETWEEN ? and ?", Date.today, Date.today + 7.days) }

  def start_time_string
    return "" unless start_time
    l(start_time.in_time_zone, format: :schedule)
  end

  def start_time_string=(start_time_string)
    self.start_time = Time.zone.parse(start_time_string)
  rescue ArgumentError
    @start_time_invalid = true
  end

  def end_time_string
    return "" unless end_time
    l(end_time.in_time_zone, format: :schedule)
  end

  def end_time_string=(end_time_string)
    self.end_time = Time.zone.parse(end_time_string)
  rescue ArgumentError
    @end_time_invalid = true
  end

  def validate
    errors.add(:start_time, "is invalid") if @start_time_invalid
    errors.add(:end_time, "is invalid") if @end_time_invalid
  end
end
