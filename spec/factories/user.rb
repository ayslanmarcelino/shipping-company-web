FactoryBot.define do
  factory :user do
    email                 { FFaker::Internet.email }
    password              { '12345678' }
    password_confirmation { '12345678' }
    is_active             { true }
    enterprise            { create(:enterprise) }
    person                { create(:person) }
  end
end
