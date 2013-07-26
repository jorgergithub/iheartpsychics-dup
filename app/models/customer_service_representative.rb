class CustomerServiceRepresentative < ActiveRecord::Base
  belongs_to :user

  scope :available, -> { where("available") }

  def self.next_available
    available.sample
  end

  def status
    available ? "Available" : "Unavailable"
  end
end
