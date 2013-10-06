require "random_utils"
require "date_time_mixin"

class Psychic < ActiveRecord::Base
  include I18n::Alchemy

  belongs_to :user

  has_many :calls
  has_many :reviews
  has_many :invoices
  has_many :schedules

  has_and_belongs_to_many :favorited_by_clients, class_name: "Client"

  accepts_nested_attributes_for :schedules,
    reject_if: proc { |attr|
      !attr["start_time_string"].present? && !attr["end_time_string"].present?
    }

  delegate :username, :first_name, :last_name, :full_name, :email,
           to: :user, allow_nil: true

  validates :extension, uniqueness: true
  validates :phone, :pseudonym, presence: true
  validates :phone, as_phone_number: true

  localize :phone, :cellular_number, :emergency_contact_number, using: PhoneParser

  mount_uploader :resume, ResumeUploader

  before_create :assign_extension

  def featured_review
    reviews.featured.first
  end

  def rating
    reviews.average(:rating)
  end

  def specialties
    %w(specialties_love_and_relationships specialties_career_and_work
       specialties_money_and_finance specialties_lost_objects
       specialties_dream_interpretation specialties_pet_and_animals
       specialties_past_lives specialties_deceased).inject([]) do |arr, sp|

      arr << sp.gsub("specialties_", "").gsub("_", " ") if send(sp)
      arr

    end.join(", ")
  end

  def alias_name
    "#{pseudonym} #{last_name.first}"
  end

  def weekly_schedule
    delta = 5 - Date.today.in_time_zone.to_date.wday
    delta += 7 if delta < 0

    first_date = Date.today.in_time_zone.to_date
    last_date = first_date + delta.days

    schedules.where('date >= ? AND date <= ?', first_date, last_date)
  end

  def next_week_schedules
    today = Date.today.in_time_zone.to_datetime.extend(DateTimeMixin)
    start_date = today.next_wday(6)
    end_date = start_date + 6.days

    schedules.where("date >= ? AND date <= ?", start_date.to_date, end_date.to_date)
  end

  def next_week_schedules_by_date
    today = Date.today.in_time_zone.to_datetime.extend(DateTimeMixin)
    start_date = today.next_wday(6)
    end_date = start_date + 6.days

    (start_date..end_date).inject({}) do |h, date|
      result = schedules.where(date: date.to_date)
      h[date] = result.load.to_a
      h[date] << schedules.new(date: date)
      h
    end
  end

  private

  def assign_extension
    return if self.extension
    existing_extensions = Psychic.pluck("extension")
    self.extension = RandomUtils.random_extension(existing_extensions)
  end
end
