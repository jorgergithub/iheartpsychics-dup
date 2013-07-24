require 'spec_helper'

describe Order do
  let(:package) { FactoryGirl.create(:package) }
  let(:order) { FactoryGirl.create(:order) }

  describe "#pay" do
    let(:stripe_client) { double(:stripe_client).as_null_object }
    let(:client) { order.client }
    let(:charge) { double(:charge, id: "charge_id") }

    before {
      order.add_package_item(package)
      client.stub(stripe_client: stripe_client)
      client.stub(charge: charge)
    }

    it "pays a given stripe token" do
      client.should_receive(:charge).with(9.99, "Order ##{order.id}")
      order.pay
    end

    context "when successful" do
      let(:transaction) { order.transactions.take }

      before { order.pay }

      it "creates one transaction" do
        expect(order.transactions.size).to eql(1)
      end

      it "sets operation" do
        expect(transaction.operation).to eql("charge")
      end

      it "sets success" do
        expect(transaction).to be_success
      end

      it "sets the charge id" do
        expect(transaction.transaction_id).to eql("charge_id")
      end
    end
  end

  describe "#add_package_item" do
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
