require "phone_formatter"

class ClientPhone < ActiveRecord::Base
  belongs_to :client
  before_save :strip_number_formatting

  validates_uniqueness_of :number

  def formatted_number
    PhoneFormatter.format(number)
  end

  private

  def strip_number_formatting
    self.number.gsub!("-", "")
    self.number = "+1#{self.number}" unless self.number =~ /^\+1/
  end
end
