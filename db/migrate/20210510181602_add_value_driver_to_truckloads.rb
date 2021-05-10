class AddValueDriverToTruckloads < ActiveRecord::Migration[6.0]
  def change
    add_column :truckloads, :value_driver, :float, null: false, precision: 9, scale: 2, default: 0.0
  end
end
