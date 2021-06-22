class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :cnh_issuing_body
      t.string :cnh_number
      t.string :cnh_record
      t.string :cnh_type
      t.date :cnh_expires_at
      t.boolean :is_employee, default: false
      t.references :enterprise, foreign_key: true
      t.references :person, foreign_key: { to_table: :user_people }

      t.timestamps
    end
  end
end
