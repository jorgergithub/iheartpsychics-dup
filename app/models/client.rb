class Client < ActiveRecord::Base
  belongs_to :user

  has_many :calls,  class_name: "ClientCall"
  has_many :phones, class_name: "ClientPhone", dependent: :destroy
  has_many :credits, dependent: :destroy

  has_and_belongs_to_many :favorite_psychics, class_name: "Psychic"

  before_save :set_encrypted_pin
  after_create :set_encrypted_pin
  after_create :add_phone_number

  delegate :username, :first_name, :last_name, :full_name, to: :user

  attr_accessor :pin, :phone_number

  def valid_pin?(pin)
    self.pin = pin
    self.encrypted_pin == calc_encrypted_pin
  end

  def minutes?
    minutes.present? and minutes != 0
  end

  def pin?
    encrypted_pin.present?
  end

  def discount_minutes(m, call)
    m = m.to_i
    credits.create(minutes: -m,
      description: "Call with #{call.psychic.full_name}", target: call)
    self.minutes ||= 0
    self.minutes -= m
    self.save
  end

  def add_minutes(m)
    credits.create(minutes: m, description: "Added minutes")
    self.minutes ||= 0
    self.minutes += m.to_i
    self.save
  end

  def seconds
    minutes * 60
  end

  def psychics
    unique_ids = [favorite_psychic_ids, calls.pluck("DISTINCT psychic_id")].flatten.uniq
    Psychic.where("id IN (?)", unique_ids)
  end

  def favorite?(psychic)
    favorite_psychic_ids.include? psychic.id
  end

  private

  def calc_encrypted_pin
    Digest::SHA1.hexdigest("#{self.id}|#{self.pin}")
  end

  def set_encrypted_pin
    return unless self.pin

    self.encrypted_pin = calc_encrypted_pin
  end

  def add_phone_number
    return unless self.phone_number
    self.phones.create(number: self.phone_number, desc: "Main")
  end
end
