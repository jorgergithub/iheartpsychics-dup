class CustomerServiceRepresentative < ActiveRecord::Base
  belongs_to :user
  delegate :username, :first_name, :last_name, :full_name, :email, to: :user

  scope :available, -> { where("available") }

  def self.next_available
    available.sample
  end

  def status
    available ? "Available" : "Unavailable"
  end
end
