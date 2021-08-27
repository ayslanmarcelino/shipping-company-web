# == Schema Information
#
# Table name: comments
#
#  id            :bigint           not null, primary key
#  attachment    :string
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint
#  truckload_id  :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_comments_on_enterprise_id  (enterprise_id)
#  index_comments_on_truckload_id   (truckload_id)
#  index_comments_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (truckload_id => truckloads.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    
  end
end
