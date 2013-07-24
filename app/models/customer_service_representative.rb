class CustomerServiceRepresentative < ActiveRecord::Base
  belongs_to :user

  def self.next_available
    first
  end
end
