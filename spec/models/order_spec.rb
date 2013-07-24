require 'spec_helper'

describe Order do
  let(:package) { FactoryGirl.create(:package) }
  let(:order) { FactoryGirl.create(:order) }

  describe "saving the order" do
    it "sets the total to the sum of items" do
      order.items.build(description: "item 1", qty: 1, unit_price: 10, total_price: 10)
      order.items.build(description: "item 2", qty: 4, unit_price: 7.5, total_price: 30)
      order.save
      expect(order.total).to eql(40.0)
    end
  end

  describe "#pay" do
    let(:stripe_client) { double(:stripe_client).as_null_object }
    let(:client) { order.client }
    let(:charge) { double(:charge, id: "charge_id") }

    before {
      order.add_package_item(package)
      client.stub(stripe_client: stripe_client)
      client.stub(:charge)
    }

    context "when not paid" do
      it "charges the order client" do
        client.should_receive(:charge).with(9.99, "Order ##{order.id}", order_id: order.id)
        order.pay
      end

      it "changes the order status to paid" do
        order.pay
        expect(order.status).to eql("paid")
      end
    end

    context "when the order is paid" do
      it "raises an error" do
        order.status = "paid"
        expect { order.pay }.to raise_error
      end
    end
  end

  describe "#paid?" do
    it "is true when status is paid" do
      order.status = "paid"
      expect(order).to be_paid
    end

    it "is false when status isn't paid" do
      expect(order).not_to be_paid
    end
  end

  describe "#add_package_item" do
    let(:package) { FactoryGirl.create(:package) }
    let(:item)    { order.reload.items.take }

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
