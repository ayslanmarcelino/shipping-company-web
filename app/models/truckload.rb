# == Schema Information
#
# Table name: truckloads
#
#  id                   :bigint           not null, primary key
#  balance_value_driver :float            default(0.0)
#  dt_number            :integer
#  is_agent             :boolean          default(FALSE)
#  value_driver         :float
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  agent_id             :bigint
#  client_id            :bigint
#  driver_id            :bigint
#  enterprise_id        :bigint
#  user_id              :bigint
#
# Indexes
#
#  index_truckloads_on_agent_id       (agent_id)
#  index_truckloads_on_client_id      (client_id)
#  index_truckloads_on_driver_id      (driver_id)
#  index_truckloads_on_enterprise_id  (enterprise_id)
#  index_truckloads_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (agent_id => agents.id)
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (driver_id => drivers.id)
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (user_id => users.id)
#
class Truckload < ApplicationRecord
  attr_accessor :validate_all

  belongs_to :enterprise
  belongs_to :client, optional: true
  belongs_to :user
  belongs_to :driver
  has_many :ctes
  has_many :transfer_requests
  belongs_to :agent, optional: true
  validates :dt_number, uniqueness: { scope: :enterprise_id }
  validates :dt_number,
            :value_driver,
            :driver_id,
            :enterprise_id,
            :user_id,
            presence: true,
            if: -> { validate_all }

  def truckload_value
    ctes.sum(&:value)
  end

  def ctes_numbers
    order_cte = ctes.order(:cte_number)
    order_cte.map(&:cte_number)
  end

  def formatted_truckload
    client_info = if client.present?
                    "#{client&.company_name} - #{client&.address&.state} | #{client&.document_number&.to_br_cnpj}"
                  else
                    'Não há cliente vinculado'
                  end

    "DT #{dt_number} | #{client_info}"
  end
end
