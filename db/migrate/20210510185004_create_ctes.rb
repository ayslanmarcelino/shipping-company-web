class CreateCtes < ActiveRecord::Migration[6.0]
  def change
    create_table :ctes do |t|
      t.integer :cte_number, null: false
      t.float :value, null: false
      t.string :cte_id
      t.string :emitter
      t.string :observation
      t.boolean :emitted_by_enterprise, default: false
      t.string :company_name_emitter
      t.string :fantasy_name_emitter
      t.string :document_number_emitter
      t.string :state_tax_number_emitter
      t.string :destiny
      t.string :destiny_city
      t.string :destiny_city_code
      t.string :destiny_complement
      t.string :destiny_country
      t.string :destiny_country_code
      t.string :destiny_neighborhood
      t.string :destiny_number
      t.string :destiny_state
      t.string :destiny_street
      t.string :destiny_zip_code
      t.datetime :emitted_at
      t.references :client, foreign_key: true
      t.references :enterprise, foreign_key: true
      t.references :truckload, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
