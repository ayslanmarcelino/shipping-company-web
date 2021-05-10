default_password = 12_345_678

enterprise_01 = Enterprise.create!(primary_color: '#FFF',
                                   secondary_color: '#111',
                                   document_number: Faker::CNPJ.numeric,
                                   company_name: Faker::Company.name,
                                   fantasy_name: Faker::Company.industry,
                                   email: Faker::Internet.email,
                                   is_active: true,
                                   opening_date: Date.today.strftime('%Y-%m-%d'))

enterprise_02 = Enterprise.create!(primary_color: '#111',
                                   secondary_color: '#FFF',
                                   document_number: Faker::CNPJ.numeric,
                                   company_name: Faker::Company.name,
                                   fantasy_name: Faker::Company.industry,
                                   email: Faker::Internet.email,
                                   is_active: false,
                                   opening_date: Date.today.strftime('%Y-%m-%d'))

user_super_admin = User.create!(email: 'super_admin@gmail.com',
                                password: default_password,
                                password_confirmation: default_password,
                                first_name: Faker::Name.name,
                                last_name: Faker::Name.name,
                                nickname: Faker::Name.name,
                                document_number: Faker::CPF.numeric,
                                is_super_admin: true,
                                is_admin: true,
                                is_active: true,
                                enterprise_id: enterprise_01.id)

user_admin = User.create!(email: 'admin@gmail.com',
                          password: default_password,
                          password_confirmation: default_password,
                          first_name: Faker::Name.name,
                          last_name: Faker::Name.name,
                          nickname: Faker::Name.name,
                          document_number: Faker::CPF.numeric,
                          is_super_admin: false,
                          is_admin: true,
                          is_active: true,
                          enterprise_id: enterprise_01.id)

user_employee = User.create!(email: 'funcionario@gmail.com',
                             password: default_password,
                             password_confirmation: default_password,
                             first_name: Faker::Name.name,
                             last_name: Faker::Name.name,
                             nickname: Faker::Name.name,
                             document_number: Faker::CPF.numeric,
                             is_super_admin: false,
                             is_admin: false,
                             is_active: true,
                             enterprise_id: enterprise_01.id)

disabled_user = User.create!(email: 'desativado@gmail.com',
                             password: default_password,
                             password_confirmation: default_password,
                             first_name: Faker::Name.name,
                             last_name: Faker::Name.name,
                             nickname: Faker::Name.name,
                             document_number: Faker::CPF.numeric,
                             is_super_admin: false,
                             is_admin: false,
                             is_active: false,
                             enterprise_id: enterprise_01.id)

user_admin_02 = User.create!(email: 'admin_02@gmail.com',
                             password: default_password,
                             password_confirmation: default_password,
                             first_name: Faker::Name.name,
                             last_name: Faker::Name.name,
                             nickname: Faker::Name.name,
                             document_number: Faker::CPF.numeric,
                             is_super_admin: false,
                             is_admin: true,
                             is_active: true,
                             enterprise_id: enterprise_02.id)

50.times {
  User.create!(email: Faker::Internet.email,
               password: default_password,
               password_confirmation: default_password,
               first_name: Faker::Name.name,
               last_name: Faker::Name.name,
               nickname: Faker::Name.name,
               document_number: Faker::CPF.numeric,
               is_super_admin: [true, false].sample,
               is_admin: [true, false].sample,
               is_active: [true, false].sample,
               enterprise_id: [enterprise_01.id, enterprise_02.id].sample)
}
