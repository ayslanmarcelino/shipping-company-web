# == Schema Information
#
# Table name: transfer_requests
#
#  id                      :bigint           not null, primary key
#  balance_value_truckload :float            default(0.0)
#  method_cd               :string
#  observation             :string
#  reject_reason           :string
#  status_cd               :string           default("pending")
#  type_cd                 :string
#  value                   :float
#  voucher                 :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  agent_id                :bigint
#  bank_account_id         :bigint
#  driver_id               :bigint
#  enterprise_id           :bigint
#  truckload_id            :bigint
#  updated_by_id           :string
#  user_id                 :bigint
#
# Indexes
#
#  index_transfer_requests_on_agent_id         (agent_id)
#  index_transfer_requests_on_bank_account_id  (bank_account_id)
#  index_transfer_requests_on_driver_id        (driver_id)
#  index_transfer_requests_on_enterprise_id    (enterprise_id)
#  index_transfer_requests_on_truckload_id     (truckload_id)
#  index_transfer_requests_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (agent_id => agents.id)
#  fk_rails_...  (bank_account_id => bank_accounts.id)
#  fk_rails_...  (driver_id => drivers.id)
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (truckload_id => truckloads.id)
#  fk_rails_...  (user_id => users.id)
#
class TransferRequest < ApplicationRecord
  TYPES = [:advance, :discharge, :balance, :agency, :full, :daily, :other].freeze
  METHODS = [:ted, :pix, :doc, :boleto, :tev, :other].freeze
  STATUS = [:rejected, :pending, :approved]

  belongs_to :enterprise
  belongs_to :truckload
  belongs_to :user
  belongs_to :agent, optional: true
  belongs_to :driver, optional: true
  belongs_to :bank_account
  paginates_per 15
  mount_uploader :voucher, Uploader::ScannedDocument

  as_enum :type, TYPES, map: :string, source: :type
  as_enum :method, METHODS, map: :string, source: :method
  as_enum :status, STATUS, map: :string, source: :status

  def basic_information
    "#{I18n.t(type_cd, scope: 'activerecord.attributes.transfer_request.types')} - #{value.to_currency}"
  end

  def full_information
    info = if truckload.ctes.count > 1
             "CT-es #{truckload.ctes_numbers.first} à #{truckload.ctes_numbers.last} - MOT. #{truckload.driver.person.full_name}"
           else
             "CT-e #{truckload.ctes_numbers.first} - MOT. #{truckload.driver.person.full_name}"
           end

    "#{I18n.t(type_cd, scope: 'activerecord.attributes.transfer_request.types')} - " \
    "#{truckload.client.company_name} - #{truckload.client.address.city} - #{truckload.client.address.state} | " \
    "#{info}"
  end
end
