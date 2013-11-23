require "random_utils"
require "date_time_mixin"
require "csv_exportable"
require "inherited_inspect"

class Psychic < ActiveRecord::Base
  include CsvExportable
  include I18n::Alchemy
  include InheritedInspect
  include TwilioIntegration

  STATES = %w[unavailable available on_a_call]

  belongs_to :user

  has_many :calls, -> { order(id: :desc) }
  has_many :events, class_name: "PsychicEvent"
  has_many :hours
  has_many :invoices
  has_many :reviews
  has_many :schedules
  has_many :callbacks

  has_and_belongs_to_many :favorited_by_clients, class_name: "Client"

  accepts_nested_attributes_for :schedules, allow_destroy: true,
    reject_if: proc { |attr|
      !attr["start_time_string"].present? && !attr["end_time_string"].present?
    }

  delegate :username, :first_name, :last_name, :full_name, :email,
           to: :user, allow_nil: true

  delegate :unavailable?, :available?, :on_a_call?, to: :current_state

  validates :extension, uniqueness: true
  validates :phone, :pseudonym, presence: true
  validates :phone, as_phone_number: true, if: ->(p) { p.phone.present? }

  localize :phone, :cellular_number, :emergency_contact_number, using: PhoneParser

  mount_uploader :resume, ResumeUploader

  before_create :assign_extension

  scope :by_alias_name, ->(value) {
    joins(:user).
    where("CONCAT(psychics.pseudonym, ' ', SUBSTR(users.last_name, 1, 1)) LIKE ?", "%#{value}%").
    order("psychics.pseudonym, SUBSTR(users.last_name, 1, 1)")
  }

  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end

  def featured_reviews
    reviews.featured
  end

  def regular_reviews
    reviews.regular
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
      if result.count > 0
        h[date] = result.load.to_a
      else
        h[date] = [schedules.new(date: date)]
      end
      h
    end
  end

  def available!
    if unavailable?
      events.create! state: "available"
      hours.create! action: "start"
    end
    CallbackWorker.perform_async(self.id)
  end

  def unavailable!
    if available?
      events.create! state: "unavailable"
      hours.create! action: "finish"
    end
  end

  def on_a_call!
    if available?
      events.create! state: "on_a_call"
      hours.create! action: "call_start"
    end
  end

  def cancel_call!(call)
    if on_a_call?
      events.create! state: "available"
      hours.last.destroy
    end
  end

  def finish_call!(call)
    if on_a_call?
      events.create! state: "available"
      hours.last.update_attribute :call_id, call.id
      hours.create! action: "call_finish", call: call
    end
  end

  def can_callback?(client)
    return false if available?
    client.balance >= price * 10
  end

  def call(call_url)
    create_call(self.phone, call_url)
  end

  def assign_extension
    return if self.extension
    existing_extensions = Psychic.pluck("extension")
    self.extension = RandomUtils.random_extension(existing_extensions)
  end

  def sign
    Sign.by_date(date_of_birth)
  end
end
