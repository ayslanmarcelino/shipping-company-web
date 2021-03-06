# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :is_active?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied, with: :access_denied

  def is_active?
    if current_user.present? && !current_user.is_active?
      sign_out(current_user)
      flash[:danger] = 'Sua conta está inativa. Para mais informações, entre em contato com o administrador da empresa.'
      root_path
    end

    if current_user.present? && !current_user.enterprise.is_active?
      sign_out(current_user)
      flash[:danger] = 'Sua empresa está inativa. Para mais informações, entre em contato com o suporte.'
      root_path
    end
  end

  def access_denied(exception)
    redirect_to root_path
    flash[:danger] = exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name nickname document_number])
  end
end
