FactoryBot.define do
  factory :truckload do
    dt_number     { Faker::Number.number(digits: 8) }
    value_driver  { Faker::Number.number(digits: 4) }
    is_agent      { [true, false].sample }
    client        { create(:client) }
    user          { create(:user) }
    enterprise    { create(:enterprise) }
  end
end
