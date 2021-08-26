# == Schema Information
#
# Table name: bank_accounts
#
#  id              :bigint           not null, primary key
#  account_name    :string
#  account_number  :string
#  account_type_cd :string
#  active          :boolean          default(TRUE)
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
#  fk_rails_...  (person_id => people.id)
#
class BankAccount < ApplicationRecord
  KEY_TYPES = [:document_number, :email, :phone_number, :random_key].freeze
  ACCOUNT_TYPES = [:saving_account, :current_account, :salary_account, :investment_account, :joint_account, :payment_account].freeze

  belongs_to :person

  as_enum :pix_key_type, KEY_TYPES, map: :string, source: :pix_key_type
  as_enum :account_type, KEY_TYPES, map: :string, source: :account_type

  cpf_or_cnpj_column :document_number, presence: false

  def self.permitted_attributes
    [:id,
     :account_name,
     :account_number,
     :agency,
     :account_type_cd,
     :bank_code,
     :document_number,
     :pix_key,
     :pix_key_type_cd,
     :person_id,
     :active,
     :_destroy]
  end

  def formatted_bank_account
    "#{bank_code} - #{agency} | #{account_number} - #{account_name}"
  end

  def formatted_pix
    if pix_key_type_cd.present?
      pix_key_type = I18n.t(pix_key_type_cd, scope: 'activerecord.attributes.bank_account.pix_types')
    end

    "Tipo: #{pix_key_type} | Chave pix: #{pix_key} | #{account_name}"
  end
end
