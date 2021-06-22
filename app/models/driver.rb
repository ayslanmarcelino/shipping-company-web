# == Schema Information
#
# Table name: drivers
#
#  id               :bigint           not null, primary key
#  cnh_expires_at   :date
#  cnh_issuing_body :string
#  cnh_number       :string
#  cnh_record       :string
#  cnh_type         :string
#  is_employee      :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  enterprise_id    :bigint
#  person_id        :bigint
#
# Indexes
#
#  index_drivers_on_enterprise_id  (enterprise_id)
#  index_drivers_on_person_id      (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (person_id => user_people.id)
#
class Driver < ApplicationRecord
  CNH_TYPES = %i[A B C D E].freeze

  belongs_to :enterprise
  belongs_to :person, class_name: 'User::Person'

  accepts_nested_attributes_for :person
end
