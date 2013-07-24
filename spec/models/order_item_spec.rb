require 'spec_helper'

describe OrderItem do
  describe "saving the order" do
    let(:order_item) { OrderItem.new(unit_price: 9.45, qty: 3) }
    it "sets the total price" do
      order_item.save
      expect(order_item.total_price).to eql(28.35)
    end
  end
end
