class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :complement
      t.string :country
      t.string :neighborhood
      t.integer :number
      t.string :state
      t.string :street
      t.string :zip_code
      t.string :country_code
      t.string :city_code

      t.timestamps
    end
  end
end
