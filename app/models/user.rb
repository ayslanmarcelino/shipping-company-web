# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  is_active              :boolean          default(FALSE)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  enterprise_id          :bigint
#  person_id              :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_enterprise_id         (enterprise_id)
#  index_users_on_person_id             (person_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (person_id => user_people.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :validate_access_data, :validate_all

  belongs_to :enterprise
  belongs_to :person

  validates :email, uniqueness: true
  validates :enterprise_id,
            :email,
            presence: true,
            if: -> { validate_access_data }

  validates :enterprise_id,
            :email,
            :person_id,
            :enterprise_id,
            presence: true,
            if: -> { validate_all }

  has_many :truckload
  has_many :cte
  has_many :roles, dependent: :destroy

  accepts_nested_attributes_for :person

  def all_roles
    roles.map(&:kind_cd).sort
  end

  def full_information
    "#{person.first_name} #{person.last_name} | #{enterprise.company_name} - #{enterprise.document_number} "
  end

  def full_name
    "#{person.first_name} #{person.last_name}"
  end
end
