class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises do |t|
      t.string :primary_color, null: false
      t.string :secondary_color, null: false
      t.string :document_number, null: false
      t.string :company_name, null: false
      t.string :fantasy_name, null: false
      t.string :email, null: false
      t.boolean :is_active, null:false, default: true
      t.date :opening_date, null: false

      t.timestamps
    end
    add_index :enterprises, :document_number, unique: true
  end
end
