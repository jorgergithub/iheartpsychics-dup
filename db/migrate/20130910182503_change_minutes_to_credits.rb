class ChangeMinutesToCredits < ActiveRecord::Migration
  def change
    rename_column :clients, :minutes, :credits
  end
end
