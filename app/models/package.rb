class Package < ActiveRecord::Base
  scope :active, -> { where("active").order("minutes") }
  scope :phone_offers, -> { where("phone").order("minutes DESC") }
end
