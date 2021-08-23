# == Schema Information
#
# Table name: transfer_requests
#
#  id              :bigint           not null, primary key
#  method_cd       :string
#  status_cd       :string           default("pending")
#  type_cd         :string
#  value           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  agent_id        :bigint
#  bank_account_id :bigint
#  driver_id       :bigint
#  enterprise_id   :bigint
#  truckload_id    :bigint
#  user_id         :bigint
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
FactoryBot.define do
  factory :transfer_request do
    method_cd { 'ted' }
    type_cd { 'advance' }
    value { '500.50' }
    enterprise { create(:enterprise) }
    truckload { create(:truckload) }
    bank_account { create(:bank_account) }
  end
end
