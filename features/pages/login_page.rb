# frozen_string_literal: true

class LoginPage < SitePrism::Page
  set_url '/users/sign_in'
  element :input_email, '#user_email'
  element :input_password, '#user_password'
  element :button_login, :button, 'Entrar'

  def fill_correct_user(user)
    input_email.set(user.email)
    input_password.set(user.password)
  end

  def fill_incorrect_user
    input_email.set('email@email.com')
    input_password.set('password')
  end

  def click_enter_login
    button_login.click
  end
end
