# == Schema Information
#
# Table name: enterprises
#
#  id              :bigint           not null, primary key
#  company_name    :string           not null
#  document_number :string           not null
#  email           :string           not null
#  fantasy_name    :string           not null
#  is_active       :boolean          default(TRUE), not null
#  logo            :string
#  opening_date    :date             not null
#  primary_color   :string           not null
#  secondary_color :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_enterprises_on_document_number  (document_number) UNIQUE
#
class Enterprise < ApplicationRecord
  has_many :users
  has_many :clients
  has_many :drivers
  has_many :user_roles, class_name: 'User::Role', inverse_of: :enterprise
  mount_uploader :logo, ImageUploader
  validates_uniqueness_of :document_number
  validates_presence_of %i[company_name fantasy_name document_number email opening_date primary_color secondary_color]
  cnpj_column :document_number
  paginates_per 25

  def formatted_enterprises
    "#{company_name} | #{document_number.to_br_cnpj}"
  end
end
