FactoryBot.define do
  factory :user_role, class: 'User::Role' do
    user
    enterprise
    kind_cd { 'master' }
  end
end
