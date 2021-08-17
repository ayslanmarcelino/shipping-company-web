FactoryBot.define do
  factory :driver do
    cnh_issuing_body { FFaker::AddressBR.state_abbr }
    cnh_number       { Faker::Number.number(digits: 10) }
    cnh_record       { Faker::Number.number(digits: 11) }
    cnh_type         { 'B' }
    cnh_expires_at   { Time.zone.today + 2.years }
    is_employee      { true }
    is_blocked       { false }
    enterprise       { create(:enterprise) }
    person           { create(:user_person) }
  end
end
