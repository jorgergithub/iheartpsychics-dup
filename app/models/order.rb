class Order < ActiveRecord::Base
  belongs_to :client
  has_many :items, class_name: "OrderItem"
  has_many :transactions

  before_save :calculate_total

  def add_package_item(pkg)
    item = items.create(package: pkg, qty: 1, unit_price: pkg.price,
                        total_price: pkg.price, description: pkg.name)
    save
    item
  end

  def pay
    raise OrderError, "order already paid" if paid?
    client.charge(total, "Order ##{id}", order_id: id)
    paid!
  end

  def paid!
    update_attributes status: "paid"
  end

  def paid?
    status == "paid"
  end

  private

  def calculate_total
    self.total = items.inject(0) { |t, i| t += i.total_price }
  end
end

class OrderError < StandardError; end
