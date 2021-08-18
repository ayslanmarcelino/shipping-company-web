# == Schema Information
#
# Table name: addresses
#
#  id           :bigint           not null, primary key
#  city         :string
#  city_code    :string
#  complement   :string
#  country      :string
#  country_code :string
#  neighborhood :string
#  number       :integer
#  state        :string
#  street       :string
#  zip_code     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Address < ApplicationRecord
  STATES = [:AC, :AL, :AM, :AP, :BA, :CE, :DF, :ES, :GO, :MA, :MG, :MS, :MT, :PA,
            :PB, :PE, :PI, :PR, :RJ, :RN, :RS, :RO, :RR, :SC, :SE, :SP, :TO].freeze
  COUNTRIES = [:Brasil].freeze

  attr_accessor :validate_address

  validates :zip_code, :neighborhood, :street, :city, :state, :country, presence: true, if: -> { validate_address || zip_code.present? }
  validate :invalid_zip_code, if: -> { validate_address && errors[:zip_code].blank? }

  before_update :normalized_zip_code
  before_save :normalized_zip_code

  def self.permitted_attributes
    [:id, :street, :number, :neighborhood, :city, :state, :zip_code, :country, :complement]
  end

  as_enum :state, STATES, map: :string, source: :state
  has_many :user_person

  def normalized_zip_code
    zip_code.gsub!(/\D/, '')
  end

  private

  def invalid_zip_code
    errors.add(:zip_code, 'inválido') if zip_code.gsub(/[^\d]/, '').to_i.zero?
  end
end
