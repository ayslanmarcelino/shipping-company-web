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
    person          { create(:user_person)                }
  end
end
