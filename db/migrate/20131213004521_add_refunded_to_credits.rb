class AddRefundedToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :refunded, :boolean

    execute <<-SQL
      UPDATE credits
      SET refunded = true
      WHERE description LIKE 'Refunded call%';
    SQL
  end
end
