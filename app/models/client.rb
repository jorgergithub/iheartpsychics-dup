class Client < ActiveRecord::Base
  belongs_to :user

  has_many :calls,  class_name: "ClientCall"
  has_many :phones, class_name: "ClientPhone"

  after_save :set_encrypted_pin
  delegate :first_name, :last_name, to: :user

  attr_accessor :pin

  def valid_pin?(pin)
    self.pin = pin
    self.encrypted_pin == calc_encrypted_pin
  end

  private

  def calc_encrypted_pin
    Digest::SHA1.hexdigest("#{self.id}|#{self.pin}")
  end

  def set_encrypted_pin
    return unless self.pin

    self.encrypted_pin = calc_encrypted_pin
  end
end
