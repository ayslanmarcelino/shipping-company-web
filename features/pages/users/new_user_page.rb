# frozen_string_literal: true

class NewUserPage < SitePrism::Page
  element :select_enterprise, '#user_enterprise_id'
  element :input_first_name, '#user_person_attributes_first_name'
  element :input_last_name, '#user_person_attributes_last_name'
  element :input_nickname, '#user_person_attributes_nickname'
  element :input_email, '#user_email'
  element :input_password, '#user_password'
  element :input_password_confirmation, '#user_password_confirmation'
  # element :checkbox_is_active, '#is_active_switch'
  element :input_birth_date, '#user_person_attributes_birth_date'
  element :input_telephone, '#user_person_attributes_telephone_number'
  element :input_phone, '#user_person_attributes_phone_number'
  element :input_document_number, '#user_person_attributes_document_number'
  element :input_rg, '#user_person_attributes_rg'
  element :input_rg_issuing_body, '#user_person_attributes_rg_issuing_body'
  element :input_zip_code, '#user_person_attributes_address_attributes_zip_code'
  element :input_street, '#user_person_attributes_address_attributes_street'
  element :input_number, '#user_person_attributes_address_attributes_number'
  element :input_complement, '#user_person_attributes_address_attributes_complement'
  element :input_neighboorhood, '#user_person_attributes_address_attributes_neighborhood'
  element :input_city, '#user_person_attributes_address_attributes_city'
  element :select_state, '#user_person_attributes_address_attributes_state'
  element :select_country, '#user_person_attributes_address_attributes_country'
  element :button_new_user, '#new_user'

  def fill_all_fields(user)
    fill_required_fields(user)
    input_nickname.set(Faker::Name.name)
    input_birth_date.set((Date.today - 18.years).strftime('%d/%m/%Y'))
    input_telephone.set(Faker::Number.number(digits: 10))
    input_phone.set(Faker::Number.number(digits: 11))
    input_document_number.set(FFaker::IdentificationBR.pretty_cpf)
    input_rg.set(Faker::Number.number(digits: 8))
    input_rg_issuing_body.set('SSP AL')
    fill_address_zip_code
    input_street.set(Faker::Address.street_name)
    input_number.set(Faker::Address.building_number)
    input_complement.set(Faker::Address.street_address)
    input_neighboorhood.set(Faker::Address.community)
    input_city.set(FFaker::AddressBR.city)
    select_state.select('AL')
    select_country.select('Brasil')
  end

  def click_new_user
    button_new_user.click
  end

  def options_in_select
    select_enterprise.all('option').count
  end

  def fill_required_fields(user)
    select_enterprise.select(user.enterprise.company_name)
    input_first_name.set(Faker::Name.first_name)
    input_last_name.set(Faker::Name.last_name)
    input_email.set(Faker::Internet.email)
    input_password.set('12345678')
    input_password_confirmation.set('12345678')
  end

  def fill_address_zip_code
    input_zip_code.set(FFaker::AddressBR.zip_code)
  end

  def fill_existing_document_number(user)
    input_document_number.set(user.person.document_number)
  end

  def fill_existing_email(user)
    input_email.set(user.email)
  end
end
