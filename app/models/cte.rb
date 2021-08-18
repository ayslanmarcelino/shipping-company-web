# == Schema Information
#
# Table name: ctes
#
#  id            :bigint           not null, primary key
#  cte_number    :integer          not null
#  emitted_at    :datetime
#  emitter       :string
#  observation   :string
#  value         :float            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  client_id     :bigint
#  cte_id        :string
#  enterprise_id :bigint
#  truckload_id  :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_ctes_on_client_id      (client_id)
#  index_ctes_on_enterprise_id  (enterprise_id)
#  index_ctes_on_truckload_id   (truckload_id)
#  index_ctes_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (truckload_id => truckloads.id)
#  fk_rails_...  (user_id => users.id)
#
class Cte < ApplicationRecord
  attr_accessor :validate_all

  belongs_to :enterprise
  belongs_to :truckload
  belongs_to :user
  belongs_to :client
  validates :cte_id, uniqueness: true
  validates :cte_number, uniqueness: { scope: :enterprise_id }
  validates :cte_number,
            :value,
            :enterprise_id,
            :truckload_id,
            :user_id,
            presence: true,
            if: -> { validate_all }
  paginates_per 25

  def truckload_client
    "#{truckload.client.company_name} - #{truckload.client.address.state} | #{truckload.client.document_number.to_br_cnpj}"
  end
end
