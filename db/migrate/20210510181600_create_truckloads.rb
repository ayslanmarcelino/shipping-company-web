class CreateTruckloads < ActiveRecord::Migration[6.0]
  def change
    create_table :truckloads do |t|
      t.integer :dt_number
      t.float :value_driver
      t.boolean :is_agent, default: false
      t.float :balance_value_driver, default: 0.0
      t.references :enterprise, foreign_key: true
      t.references :client, foreign_key: true
      t.references :user, foreign_key: true
      t.references :driver, foreign_key: true
      t.references :agent, null: true, foreign_key: true

      t.timestamps
    end
  end
end
