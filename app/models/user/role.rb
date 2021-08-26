# == Schema Information
#
# Table name: user_roles
#
#  id            :bigint           not null, primary key
#  kind_cd       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_user_roles_on_enterprise_id  (enterprise_id)
#  index_user_roles_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (user_id => users.id)
#
class User::Role < ApplicationRecord
  KINDS_MASTER = [:master].freeze
  KINDS_CLIENT = %i[owner operational financial].freeze

  KINDS = KINDS_MASTER + KINDS_CLIENT

  attr_accessor :validate_all

  validates :kind_cd,
            :enterprise_id,
            :user_id,
            presence: true,
            if: -> { validate_all }

  belongs_to :user
  belongs_to :enterprise

  as_enum :kind, KINDS, prefix: true, map: :string

  validates :kind_cd, uniqueness: { scope: :user_id }

  paginates_per 25

  def translated_kinds
    I18n.t(:kind_cd, scope: 'activerecord.attributes.user/role.kinds')
  end
end
