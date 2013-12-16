class Package < ActiveRecord::Base
  scope :active, -> { where("active").order("credits") }
  scope :phone_offers, -> { active.where("phone").order("credits DESC") }
  has_many :order_items, dependent: :restrict

  validates_presence_of :name, :price, :credits

  def discount
    (100 - ((price / credits) * 100)).round
  end
end
