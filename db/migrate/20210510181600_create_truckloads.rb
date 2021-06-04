class CreateTruckloads < ActiveRecord::Migration[6.0]
  def change
    create_table :truckloads do |t|
      t.integer :dt_number, null: false
      t.float :value_driver, null: false
      t.boolean :is_agent
      t.references :enterprise, foreign_key: true
      t.references :client, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
