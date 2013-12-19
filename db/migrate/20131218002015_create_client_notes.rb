class CreateClientNotes < ActiveRecord::Migration
  def change
    create_table :client_notes do |t|
      t.text :description
      t.references :client, index: true

      t.timestamps
    end

    add_foreign_key :client_notes, :clients, column: :client_id
  end
end
