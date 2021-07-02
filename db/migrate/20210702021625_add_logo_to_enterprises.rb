class AddLogoToEnterprises < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :logo, :string
  end
end
