class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :fantasy_name
      t.string :company_name
      t.string :document_number
      t.string :email
      t.string :phone_number
      t.string :responsible
      t.string :telephone_number
      t.string :observation
      t.boolean :is_active, default: true
      t.references :address, null: false, foreign_key: true
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
    add_index :clients, :document_number, unique: true
  end
end
