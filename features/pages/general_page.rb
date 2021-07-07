# frozen_string_literal: true

class GeneralPage < SitePrism::Page
  element :modal_confirmation, '.swal2-popup'
  element :button_yes, '.swal2-confirm'

  def modal?
    modal_confirmation.present?
  end

  def click_yes
    button_yes.click
  end
end
