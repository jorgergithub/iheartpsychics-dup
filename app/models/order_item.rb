class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :package

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price ||= unit_price.to_f * qty
  end
end
