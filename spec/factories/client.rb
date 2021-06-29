FactoryBot.define do
  factory :client do
    company_name      { Faker::Company.industry }
    fantasy_name      { Faker::Company.name }
    document_number   { FFaker::IdentificationBR.pretty_cnpj }
    email             { Faker::Internet.email }
    observation       { 'Observação qualquer' }
    responsible       { FFaker::NameBR.name }
    phone_number      { '82990984984' }
    telephone_number  { '8233449900' }
    address           { create(:address) }
    enterprise        { create(:enterprise) }
    is_active         { true }
  end
end
