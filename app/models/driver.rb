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
#  is_blocked       :boolean          default(FALSE)
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

  attr_accessor :validate_all

  belongs_to :enterprise
  belongs_to :person, class_name: 'User::Person'
  has_many :truckloads

  accepts_nested_attributes_for :person

  validates :cnh_record, :cnh_number, uniqueness: { scope: :enterprise_id }
  validates :cnh_expires_at,
            :cnh_issuing_body,
            :cnh_number,
            :cnh_record,
            :cnh_type,
            :enterprise_id,
            presence: true,
            if: -> { validate_all }

  paginates_per 25

  def formatted_name
    "#{person.full_name} | #{person.document_number.to_br_cpf}"
  end
end
