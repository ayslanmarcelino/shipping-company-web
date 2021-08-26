# frozen_string_literal: true

enterprise1 = FactoryBot.create(:enterprise, is_active: true)
FactoryBot.create(:enterprise, is_active: false)
user_master = FactoryBot.create(:user, email: 'master@gmail.com', enterprise: enterprise1)
FactoryBot.create(:user_role, user: user_master, enterprise: enterprise1)
user_owner = FactoryBot.create(:user, email: 'owner@gmail.com', enterprise: enterprise1)
FactoryBot.create(:user_role, kind: :owner, user: user_owner, enterprise: enterprise1)
user_operational = FactoryBot.create(:user, email: 'operational@gmail.com', enterprise: enterprise1)
FactoryBot.create(:user_role, kind: :operational, user: user_operational, enterprise: enterprise1)
disabled_user = FactoryBot.create(:user, is_active: false, enterprise: enterprise1)
FactoryBot.create(:user_role, user: disabled_user, enterprise: enterprise1)
bank_account = FactoryBot.create(:bank_account)
person = FactoryBot.create(:person)
person.bank_accounts << bank_account
client = FactoryBot.create(:client, enterprise: enterprise1)
driver = FactoryBot.create(:driver, enterprise: enterprise1, person: person)
agent = FactoryBot.create(:agent, enterprise: enterprise1)
truckload = FactoryBot.create(:truckload,
                              user: user_operational,
                              enterprise: enterprise1,
                              client: client,
                              driver: driver,
                              agent: agent)
FactoryBot.create(:cte, truckload: truckload, user: user_operational, enterprise: enterprise1, client: client)
%i[pending approved rejected].each do |status|
  FactoryBot.create(:transfer_request,
                    truckload: truckload,
                    driver: driver,
                    bank_account: driver.person.bank_accounts.first,
                    enterprise: enterprise1,
                    user: user_operational,
                    status_cd: status)
end
