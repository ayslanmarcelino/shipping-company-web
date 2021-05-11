FactoryBot.define do
  factory :address do
    street       { Faker::Address.street_name }
    number       { Faker::Address.building_number }
    neighborhood { Faker::Address.community }
    state        { FFaker::AddressBR.state_abbr }
    city         { FFaker::AddressBR.city }
    zip_code     { FFaker::AddressBR.zip_code }
    country      { 'Brasil' }
    complement   { Faker::Address.street_address }

    trait :empty do
      street {}
      number {}
      neighborhood {}
      city {}
      state {}
      zip_code {}
      country {}
      complement {}
    end
  end
end
