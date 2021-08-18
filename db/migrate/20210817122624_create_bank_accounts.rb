class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.string :account_name
      t.string :account_number
      t.string :account_type_cd
      t.string :agency
      t.string :bank_code
      t.string :document_number
      t.string :pix_key
      t.string :pix_key_type_cd
      t.references :person, foreign_key: { to_table: :user_people }

      t.timestamps
    end
  end
end
