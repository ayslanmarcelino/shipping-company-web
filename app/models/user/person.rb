# == Schema Information
#
# Table name: user_people
#
#  id               :bigint           not null, primary key
#  birth_date       :datetime
#  document_number  :string
#  first_name       :string
#  last_name        :string
#  nickname         :string
#  phone_number     :string
#  rg               :string
#  rg_issuing_body  :string
#  telephone_number :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  address_id       :bigint
#
# Indexes
#
#  index_user_people_on_address_id  (address_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#
class User::Person < ApplicationRecord
  attr_accessor :validate_access_data, :validate_all

  has_one :user
  has_many :bank_accounts

  belongs_to :address, optional: true

  validates :document_number, uniqueness: true, if: -> { document_number.present? }
  validates :first_name,
            :last_name,
            presence: true,
            if: -> { validate_access_data }
  validates :first_name,
            :last_name,
            :birth_date,
            :document_number,
            :phone_number,
            :phone_number,
            :rg,
            :rg_issuing_body,
            presence: true,
            if: -> { validate_all }

  accepts_nested_attributes_for :address
  cpf_column :document_number, presence: false

  def self.permitted_attributes
    [:id,
     :birth_date,
     :document_number,
     :first_name,
     :last_name,
     :nickname,
     :phone_number,
     :rg,
     :rg_issuing_body,
     :telephone_number]
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
