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
  has_one :user

  belongs_to :address, optional: true

  validates :document_number, uniqueness: true, on: :create, if: -> { document_number.present? }

  accepts_nested_attributes_for :address

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

  def full_information
    "#{first_name} #{last_name} | #{enterprise.company_name} - #{enterprise.document_number} "
  end
end
