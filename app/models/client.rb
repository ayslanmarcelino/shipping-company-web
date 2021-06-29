# == Schema Information
#
# Table name: clients
#
#  id               :bigint           not null, primary key
#  company_name     :string
#  document_number  :string
#  email            :string
#  fantasy_name     :string
#  is_active        :boolean          default(TRUE)
#  observation      :string
#  phone_number     :string
#  responsible      :string
#  telephone_number :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  address_id       :bigint           not null
#  enterprise_id    :bigint           not null
#
# Indexes
#
#  index_clients_on_address_id     (address_id)
#  index_clients_on_enterprise_id  (enterprise_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (enterprise_id => enterprises.id)
#
class Client < ApplicationRecord
  attr_accessor :validate_all

  belongs_to :address, optional: true
  belongs_to :enterprise

  accepts_nested_attributes_for :address

  validates :document_number, uniqueness: { scope: :enterprise_id }
  validates :company_name,
            :document_number,
            :email,
            :fantasy_name,
            :phone_number,
            :responsible,
            :address_id,
            :enterprise_id,
            presence: true,
            if: -> { validate_all }

  def formatted_name
    "#{company_name} - #{address.state} | #{document_number.to_br_cnpj}"
  end
end
