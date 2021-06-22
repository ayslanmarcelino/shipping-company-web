# == Schema Information
#
# Table name: truckloads
#
#  id            :bigint           not null, primary key
#  dt_number     :integer          not null
#  is_agent      :boolean
#  value_driver  :float            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  client_id     :bigint
#  driver_id     :bigint
#  enterprise_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_truckloads_on_client_id      (client_id)
#  index_truckloads_on_driver_id      (driver_id)
#  index_truckloads_on_enterprise_id  (enterprise_id)
#  index_truckloads_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (driver_id => drivers.id)
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (user_id => users.id)
#
class Truckload < ApplicationRecord
  belongs_to :enterprise
  belongs_to :client
  belongs_to :user
  belongs_to :driver
  has_many :cte
  validates :dt_number, uniqueness: { scope: :enterprise_id }

  def truckload_value
    cte.sum(&:value)
  end

  def ctes_numbers
    order_cte = cte.order(:cte_number)
    order_cte.map(&:cte_number)
  end

  def formatted_truckload
    "DT #{dt_number} | #{client.company_name} - #{client.address.state} | #{client.document_number.to_br_cnpj}"
  end
end
