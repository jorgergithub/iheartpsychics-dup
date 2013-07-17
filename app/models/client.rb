class Client < ActiveRecord::Base
  belongs_to :user
  before_save :set_encrypted_pin

  has_many :phones, :class_name => "ClientPhone"

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
