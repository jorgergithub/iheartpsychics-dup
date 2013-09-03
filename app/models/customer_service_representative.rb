class CustomerServiceRepresentative < ActiveRecord::Base
  include I18n::Alchemy

  belongs_to :user
  delegate :username, :first_name, :last_name, :full_name, :email, to: :user

  localize :phone, :using => PhoneParser

  scope :available, -> { where("available") }

  def self.next_available
    available.sample
  end

  def status
    available ? "Available" : "Unavailable"
  end
end
