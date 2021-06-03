FactoryBot.define do
  factory :user do
    email                 { FFaker::Internet.email }
    first_name            { FFaker::Name.first_name }
    last_name             { FFaker::Name.last_name }
    nickname              { FFaker::Name.name }
    document_number       { FFaker::IdentificationBR.cpf }
    password              { '12345678' }
    password_confirmation { '12345678' }
    is_active             { true }
    address               { create(:address) }
    enterprise            { create(:enterprise) }
  end
end
