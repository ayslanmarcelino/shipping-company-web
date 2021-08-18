class CreateCtes < ActiveRecord::Migration[6.0]
  def change
    create_table :ctes do |t|
      t.integer :cte_number, null: false
      t.float :value, null: false
      t.string :cte_id
      t.string :emitter
      t.string :observation
      t.boolean :emitted_by_enterprise, default: false
      t.datetime :emitted_at
      t.references :client, foreign_key: true
      t.references :enterprise, foreign_key: true
      t.references :truckload, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
