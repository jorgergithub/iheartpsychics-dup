class ScheduleJob < ActiveRecord::Base
  has_enumeration_for :week_day
  has_enumeration_for :at, with: Hour

  validates :description, :week_day, :at, :model, :action, presence: true
end
