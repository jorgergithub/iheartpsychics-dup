class Tier < ActiveRecord::Base
  has_many :invoices

  def self.for(minutes)
    Tier.where("`from` <= ? AND `to` >= ?", minutes, minutes).take
  end

  def payout_for(call)
    call.cost * percent / 100
  end
end
