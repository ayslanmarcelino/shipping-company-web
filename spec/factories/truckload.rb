FactoryBot.define do
  factory :truckload do
    faker_value_driver = Faker::Number.number(digits: 4)
    dt_number     { Faker::Number.number(digits: 8) }
    value_driver  { faker_value_driver }
    balance_value_driver { faker_value_driver }
    is_agent      { true }
    agent         { create(:agent) }
    user          { create(:user) }
    enterprise    { create(:enterprise) }
    driver        { create(:driver) }
  end
end
