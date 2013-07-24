require 'spec_helper'

describe Order do
  describe "#add_package_item" do
    let(:order)   { FactoryGirl.create(:order)   }
    let(:package) { FactoryGirl.create(:package) }
    let(:item)    { order.items.take }

    before {
      order.add_package_item package
    }

    it "creates a new OrderItem" do
      expect(order.items.size).to eql(1)
    end

    it "sets the package" do
      expect(item.package).to eql(package)
    end

    it "sets the quantity to 1" do
      expect(item.qty).to eql(1)
    end

    it "sets the unit price" do
      expect(item.unit_price).to eql(package.price)
    end

    it "sets the total price" do
      expect(item.total_price).to eql(package.price)
    end

    it "sets the description" do
      expect(item.description).to eql(package.name)
    end
  end
end
