class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_active, :boolean, default: false
    add_reference :users, :enterprise, foreign_key: true
    add_reference :users, :person, index: true, foreign_key: true
  end
end
