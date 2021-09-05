class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :document_number
      t.string :phone_number
      t.string :telephone_number
      t.string :rg
      t.string :rg_issuing_body
      t.datetime :birth_date
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
