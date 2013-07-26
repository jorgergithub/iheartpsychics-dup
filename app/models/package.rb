class Package < ActiveRecord::Base
  scope :active, -> { where("active").order("minutes") }
  scope :phone_offers, -> { where("true").order("minutes DESC") }
end
