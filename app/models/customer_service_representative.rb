class CustomerServiceRepresentative < ActiveRecord::Base
  include I18n::Alchemy

  belongs_to :user

  delegate :username, :first_name, :last_name, :full_name, :email,
           to: :user, allow_nil: true

  validates :phone, presence: true
  validates :phone, as_phone_number: true

  localize :phone, using: PhoneParser

  scope :available, -> { where("available") }

  def self.next_available
    available.sample
  end

  def status
    available ? "Available" : "Unavailable"
  end
end
