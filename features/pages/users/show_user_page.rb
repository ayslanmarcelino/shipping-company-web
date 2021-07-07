# frozen_string_literal: true

class ShowUserPage < SitePrism::Page
  element :nav_pills, '#cardPillVertical'
  element :nav_personal, '#personal-menu'
  element :nav_document, '#document-menu'
  element :nav_address, '#address-menu'
  element :th_full_name, 'th', text: 'Nome completo'
  element :th_nickname, 'th', text: 'Apelido'
  element :th_email, 'th', text: 'E-mail'
  element :th_birth_date, 'th', text: 'Data de nascimento'
  element :th_phone, 'th', text: 'Telefone'
  element :th_telephone, 'th', text: 'Celular'
  element :th_document_number, 'th', text: 'CPF/CNPJ'
  element :th_rg, 'th', text: 'RG'
  element :th_rg_issuing_body, 'th', text: 'Orgão expedidor'
  element :th_zip_code, 'th', text: 'CEP'
  element :th_street, 'th', text: 'Logradouro'
  element :th_number, 'th', text: 'Número'
  element :th_complement, 'th', text: 'Complemento'
  element :th_neighborhood, 'th', text: 'Bairro'
  element :th_city, 'th', text: 'Cidade'
  element :th_state, 'th', text: 'Estado'
  element :th_country, 'th', text: 'País'

  def show_user_page?
    nav_pills.present?
    nav_personal.present?
    nav_document.present?
    nav_address.present?
  end

  def nav_personal?
    th_full_name.present?
    th_nickname.present?
    th_email.present?
    th_birth_date.present?
    th_phone.present?
    th_telephone.present?
  end

  def click_nav_document
    nav_document.click
  end

  def nav_document?
    th_document_number.present?
    th_rg.present?
    th_rg_issuing_body.present?
  end

  def click_nav_address
    nav_address.click
  end

  def nav_address?
    th_zip_code.present?
    th_street.present?
    th_number.present?
    th_complement.present?
    th_neighborhood.present?
    th_city.present?
    th_state.present?
    th_country.present?
  end
end
