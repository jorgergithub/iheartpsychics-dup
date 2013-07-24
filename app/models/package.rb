class Package < ActiveRecord::Base
  scope :active, -> { where("active").order("minutes") }
end
