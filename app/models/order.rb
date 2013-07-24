class Order < ActiveRecord::Base
  belongs_to :client
  has_many :items, class_name: "OrderItem"
  has_many :transactions

  def add_package_item(pkg)
    items.create(package: pkg, qty: 1, unit_price: pkg.price,
                 total_price: pkg.price, description: pkg.name)
  end

  def pay
    transaction = transactions.create(operation: "charge")
    charge = client.charge(total, "Order ##{id}")
    transaction.update_attributes success: true, transaction_id: charge.id
  end
end
