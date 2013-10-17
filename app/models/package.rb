class Package < ActiveRecord::Base
  scope :active, -> { where("active").order("credits") }
  scope :phone_offers, -> { active.where("phone").order("credits DESC") }

  def to_paypal(view_context, order_id)
    PayPal.new(view_context, order_id, name, price)
  end
end
