FactoryBot.define do
  factory :cte do
    cte_number { Faker::Number.number(digits: 6) }
    value      { Faker::Number.number(digits: 5) }
    truckload  { create(:truckload) }
    user       { create(:user) }
    enterprise { create(:enterprise) }
  end
end
