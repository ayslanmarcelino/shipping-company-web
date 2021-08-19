FactoryBot.define do
  factory :agent do
    enterprise { create(:enterprise) }
    person { create(:user_person) }
  end
end
