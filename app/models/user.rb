# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  document_number        :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  is_active              :boolean          default(FALSE)
#  is_admin               :boolean          default(FALSE)
#  is_super_admin         :boolean          default(FALSE)
#  last_name              :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  nickname               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  address_id             :bigint
#  enterprise_id          :bigint
#
# Indexes
#
#  index_users_on_address_id            (address_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_enterprise_id         (enterprise_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (enterprise_id => enterprises.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :enterprise
  belongs_to :address, optional: true

  validates :document_number, uniqueness: { scope: :enterprise_id }
  validates_presence_of %i[first_name last_name email document_number enterprise_id]

  accepts_nested_attributes_for :address

  has_many :truckload

  def status_users
    return t('application.disabled') unless is_active
    return t('application.super_admin') if is_active && is_super_admin
    return t('application.admin') if is_active && is_admin
    return t('application.employee') if is_active && !is_admin && !is_super_admin
  end
end
