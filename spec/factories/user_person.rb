FactoryBot.define do
  factory :user_person, class: 'User::Person' do
    birth_date            { DateTime.now - 18.years }
    first_name            { FFaker::Name.first_name }
    last_name             { FFaker::Name.last_name }
    nickname              { FFaker::Name.name }
    phone_number          { Faker::Number.number(digits: 11) }
    rg                    { Faker::Number.number(digits: 8) }
    rg_issuing_body       { 'SSP AL' }
    telephone_number      { Faker::Number.number(digits: 10) }
    document_number       { FFaker::IdentificationBR.pretty_cpf }
    address               { create(:address) }
  end
end
