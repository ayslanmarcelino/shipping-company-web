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
FactoryBot.define do
  factory :bank_account do
    account_name    { 'Ayslan Marcelino'                  }
    account_number  { '2398-2'                            }
    account_type_cd { 'current_account'                   }
    agency          { '0001'                              }
    bank_code       { '104'                               }
    document_number { FFaker::IdentificationBR.pretty_cpf }
    pix_key         { FFaker::IdentificationBR.pretty_cpf }
    pix_key_type_cd { 'document_number'                   }
    person          { create(:person)                     }
  end
end
