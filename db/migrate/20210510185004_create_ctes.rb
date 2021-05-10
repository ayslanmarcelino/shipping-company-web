class CreateCtes < ActiveRecord::Migration[6.0]
  def change
    create_table :ctes do |t|
      t.integer :cte_number, null: false
      t.float :value, null: false
      t.references :enterprise, foreign_key: true
      t.references :truckload, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :ctes, :cte_number, unique: true
  end
end
