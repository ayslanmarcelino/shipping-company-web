FactoryBot.define do
  factory :enterprise do
    primary_color     { Faker::Color.hex_color }
    secondary_color   { Faker::Color.hex_color }
    document_number   { FFaker::IdentificationBR.cnpj }
    email             { Faker::Internet.email }
    company_name      { FFaker::NameBR.name }
    fantasy_name      { FFaker::NameBR.name }
    opening_date      { (Date.today - 30).strftime('%Y-%m-%d') }
    is_active         { true }
  end
end
