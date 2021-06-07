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
  KINDS_CLIENT = [:owner, :operational].freeze

  KINDS = KINDS_MASTER + KINDS_CLIENT

  belongs_to :user
  belongs_to :enterprise

  as_enum :kind, KINDS, prefix: true, map: :string

  validates :kind_cd, uniqueness: { scope: :user_id }
end
