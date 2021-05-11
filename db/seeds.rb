enterprise_01 = FactoryBot.create(:enterprise, is_active: true)
enterprise_02 = FactoryBot.create(:enterprise, is_active: false)
user_super_admin = FactoryBot.create(:user, email: 'ayslan@gmail.com', enterprise: enterprise_01)
user_admin = FactoryBot.create(:user, is_super_admin: false, enterprise: enterprise_01)
user_employee = FactoryBot.create(:user, is_admin: false, is_super_admin: false, enterprise: enterprise_01)
disabled_user = FactoryBot.create(:user, is_active: false, enterprise: enterprise_01)
user_admin_02 = FactoryBot.create(:user, is_active: false, enterprise: enterprise_02)
client = FactoryBot.create(:client, enterprise: enterprise_01)
truckload = FactoryBot.create(:truckload, user: user_employee, enterprise: enterprise_01, client: client)
cte = FactoryBot.create(:cte, truckload: truckload, user: user_employee, enterprise: enterprise_01)
