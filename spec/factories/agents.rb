# == Schema Information
#
# Table name: agents
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint
#  person_id     :bigint
#
# Indexes
#
#  index_agents_on_enterprise_id  (enterprise_id)
#  index_agents_on_person_id      (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (person_id => people.id)
#
FactoryBot.define do
  factory :agent do
    enterprise { create(:enterprise) }
    person { create(:person) }
  end
end
