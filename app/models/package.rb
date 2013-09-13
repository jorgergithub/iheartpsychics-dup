class Package < ActiveRecord::Base
  scope :active, -> { where("active").order("credits") }
  scope :phone_offers, -> { active.where("phone").order("credits DESC") }
end
