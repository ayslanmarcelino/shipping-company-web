FactoryBot.define do
  factory :truckload do
    dt_number     { Faker::Number.number(digits: 8) }
    value_driver  { Faker::Number.number(digits: 4) }
    is_agent      { true }
    agent         { create(:agent) }
    user          { create(:user) }
    enterprise    { create(:enterprise) }
    driver        { create(:driver) }
  end
end
