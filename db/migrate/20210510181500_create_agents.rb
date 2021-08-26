class CreateAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :agents do |t|
      t.references :enterprise, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
