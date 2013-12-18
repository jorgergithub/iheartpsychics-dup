class AddDisabledToClients < ActiveRecord::Migration
  def change
    add_column :clients, :disabled, :boolean, default: false
  end
end
