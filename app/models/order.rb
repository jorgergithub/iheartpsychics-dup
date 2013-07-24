class Order < ActiveRecord::Base
  belongs_to :client
  has_many :items, class_name: "OrderItem"

  def add_package_item(pkg)
    items.create(package: pkg, qty: 1, unit_price: pkg.price,
                 total_price: pkg.price, description: pkg.name)
  end
end
