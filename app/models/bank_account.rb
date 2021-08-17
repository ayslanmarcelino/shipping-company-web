# == Schema Information
#
# Table name: bank_accounts
#
#  id              :bigint           not null, primary key
#  account_number  :string
#  account_type_cd :string
#  agency          :string
#  bank_code       :string
#  document_number :string
#  pix_key         :string
#  pix_key_type_cd :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  person_id       :bigint
#
# Indexes
#
#  index_bank_accounts_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => user_people.id)
#
class BankAccount < ApplicationRecord
  KEY_TYPES = [:document_number, :email, :phone_number, :random_key].freeze
  ACCOUNT_TYPES = [:saving_account, :current_account, :salary_account, :investment_account, :joint_account, :payment_account].freeze

  belongs_to :person, class_name: 'User::Person'

  as_enum :pix_key_type, KEY_TYPES, map: :string, source: :pix_key_type
  as_enum :account_type, KEY_TYPES, map: :string, source: :account_type

  cpf_column :document_number, presence: false

  def self.permitted_attributes
    [:id, :account_number, :agency, :account_type_cd, :bank_code, :document_number, :pix_key, :pix_key_type_cd, :person_id, :_destroy]
  end
end
