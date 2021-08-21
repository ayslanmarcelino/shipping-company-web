class CreateTransferRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :transfer_requests do |t|
      t.float :value
      t.string :type_cd
      t.string :method_cd
      t.string :status_cd, default: 'pending'
      t.references :user, foreign_key: true
      t.references :truckload, foreign_key: true
      t.references :driver, foreign_key: true
      t.references :agent, foreign_key: true
      t.references :bank_account, foreign_key: true
      t.references :enterprise, foreign_key: true

      t.timestamps
    end
  end
end
