FactoryBot.define do
  factory :cte do
    cte_id      { "CTe#{Faker::Number.number(digits: 44)}" }
    emitter     { 'Ayslan' }
    emitted_at  { Time.zone.now }
    observation { 'Emitido por Ayslan, coletado ontem.' }
    cte_number  { Faker::Number.number(digits: 6) }
    value       { Faker::Number.number(digits: 5) }
    client      { create(:client) }
    truckload   { create(:truckload) }
    user        { create(:user) }
    enterprise  { create(:enterprise) }
  end
end
