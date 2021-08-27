class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :description
      t.string :attachment
      t.references :truckload, foreign_key: true
      t.references :user, foreign_key: true
      t.references :enterprise, foreign_key: true

      t.timestamps
    end
  end
end
