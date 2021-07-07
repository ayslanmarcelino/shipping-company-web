# frozen_string_literal: true

class MenuPage < SitePrism::Page
  element :menu_dashboard, '#dashboard'
  element :menu_truckloads, '#truckloads'
  element :menu_ctes, '#ctes'
  element :menu_clients, '#clients'
  element :menu_drivers, '#drivers'
  element :menu_users, '#users'
  element :menu_user_roles, '#user_roles'
  element :menu_enterprises, '#enterprises'

  def operational_menu?
    menu_dashboard.present?
    menu_truckloads.present?
    menu_ctes.present?
    menu_clients.present?
    menu_drivers.present?
  end

  def owner_menu?
    operational_menu?
    menu_users.present?
    menu_user_roles.present?
  end

  def master_menu?
    operational_menu?
    owner_menu?
  end

  def click_users
    menu_users.click
  end
end
